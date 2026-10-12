pub mod handler;

use std::collections::HashMap;
use std::sync::{Arc, Mutex};
use tokio::sync::mpsc::UnboundedSender;
use uuid::Uuid;
use redis::aio::ConnectionManager;

#[derive(Clone)]
pub struct WsBroadcaster {
    senders: Arc<Mutex<HashMap<Uuid, Vec<UnboundedSender<String>>>>>,
    redis: Option<ConnectionManager>,
}

impl WsBroadcaster {
    pub fn new(redis: Option<ConnectionManager>) -> Self {
        Self {
            senders: Arc::new(Mutex::new(HashMap::new())),
            redis,
        }
    }

    pub fn register(&self, user_id: Uuid, tx: UnboundedSender<String>) {
        let mut map = self.senders.lock().unwrap();
        map.entry(user_id).or_default().push(tx);
    }

    pub fn unregister(&self, user_id: Uuid) {
        let mut map = self.senders.lock().unwrap();
        map.remove(&user_id);
    }

    /// Broadcasts a JSON string to all active sessions of a specific user.
    pub async fn send_to_user(&self, target_user: Uuid, payload: &str) {
        // 1. Deliver locally to all active sockets on this process
        {
            let mut map = self.senders.lock().unwrap();
            if let Some(list) = map.get_mut(&target_user) {
                list.retain(|tx| tx.send(payload.to_string()).is_ok());
            }
        }

        // 2. Publish to Redis channel so any other worker / instance delivers it too
        if let Some(mut redis) = self.redis.clone() {
            let channel = format!("chat:user:{target_user}");
            let _: Result<(), _> = redis::cmd("PUBLISH")
                .arg(&channel)
                .arg(payload)
                .query_async(&mut redis)
                .await;
        }
    }
}
