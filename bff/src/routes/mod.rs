use actix_web::web;

use crate::module::auth::handler as auth_handler;
use crate::module::dating::handler as dating;
use crate::module::health::handler::health_status;
use crate::module::legal;
use crate::module::user::handler as user_handler;

pub fn config(cfg: &mut web::ServiceConfig) {
    cfg.route("/privacy", web::get().to(legal::privacy))
        .route("/terms", web::get().to(legal::terms))
        .route("/safety", web::get().to(legal::safety))
        .route("/child-safety", web::get().to(legal::safety))
        .route("/delete-account", web::get().to(legal::delete_account));

    cfg.service(
        web::scope("/api/v1")
            .route("/health", web::get().to(health_status))
            .route("/legal/privacy", web::get().to(legal::privacy))
            .route("/legal/terms", web::get().to(legal::terms))
            .route("/legal/safety", web::get().to(legal::safety))
            .route(
                "/legal/delete-account",
                web::get().to(legal::delete_account),
            )

            .service(
                web::scope("/auth")
                    .route("/register", web::post().to(auth_handler::register))
                    .route("/login", web::post().to(auth_handler::login))
                    .route("/refresh", web::post().to(auth_handler::refresh))
                    .route("/logout", web::post().to(auth_handler::logout))
                    .route(
                        "/verify-email",
                        web::post().to(auth_handler::verify_email_post),
                    )
                    .route(
                        "/verify-email/{token}",
                        web::get().to(auth_handler::verify_email_get),
                    )
                    .route(
                        "/password-reset",
                        web::post().to(auth_handler::request_password_reset),
                    )
                    .route(
                        "/password-reset/confirm",
                        web::post().to(auth_handler::confirm_password_reset),
                    )
                    .route("/google", web::get().to(auth_handler::google_start))
                    .route("/google", web::post().to(auth_handler::google_token))
                    .route(
                        "/google/callback",
                        web::get().to(auth_handler::google_callback),
                    )
                    .route("/phone/start", web::post().to(auth_handler::phone_start))
                    .route("/phone/verify", web::post().to(auth_handler::phone_verify)),
            )
            .service(
                web::scope("/user")
                    .route("/me", web::get().to(user_handler::me))
                    .route("/me", web::delete().to(dating::delete_account))
                    .route(
                        "/change-password",
                        web::post().to(user_handler::change_password),
                    )
                    .route("/profile", web::get().to(dating::get_profile))
                    .route("/profile", web::patch().to(dating::patch_profile))
                    .route("/profile/location", web::post().to(dating::set_location))
                    .route("/profile/photos", web::post().to(dating::upload_photo))
                    .route(
                        "/profile/photos/reorder",
                        web::post().to(dating::reorder_photos),
                    )
                    .route(
                        "/profile/photos/{id}",
                        web::delete().to(dating::delete_photo),
                    )
                    .route("/devices", web::post().to(dating::register_device))
                    .route("/devices", web::delete().to(dating::unregister_device))
                    .route("/blocked", web::get().to(dating::blocked)),
            )
            .route("/stories", web::get().to(dating::stories))
            .route("/stories", web::post().to(dating::add_note))
            .route("/advisors", web::get().to(dating::advisors))
            .route("/advisors/{id}", web::get().to(dating::advisor_profile))
            .route("/advisors/{id}/follow", web::post().to(dating::toggle_follow))
            .route("/notifications", web::get().to(dating::notifications))
            .route(
                "/notifications/{id}/confirm",
                web::post().to(dating::confirm_notification),
            )
            .route(
                "/notifications/{id}",
                web::delete().to(dating::delete_notification),
            )
            .route("/discover/nearby", web::get().to(dating::nearby))
            .route("/discover/people/{id}", web::get().to(dating::person))
            .route("/swipe", web::post().to(dating::swipe))
            .route("/likes", web::get().to(dating::likes))
            .route("/matches", web::get().to(dating::matches))
            .route("/matches/{id}", web::delete().to(dating::unmatch))
            .route(
                "/messages/conversations",
                web::get().to(dating::conversations),
            )
            .route(
                "/messages/conversations/{id}",
                web::get().to(dating::list_messages),
            )
            .route(
                "/messages/conversations/{id}",
                web::post().to(dating::send_message),
            )
            .route("/feed", web::get().to(dating::feed))
            .route("/feed", web::post().to(dating::create_post))
            .route("/feed/{id}", web::get().to(dating::get_post))
            .route("/feed/{id}/like", web::post().to(dating::toggle_like))
            .route("/feed/{id}/vote", web::post().to(dating::vote_verdict))
            .route("/feed/{id}/save", web::post().to(dating::toggle_save))
            .route("/feed/{id}/comments", web::get().to(dating::comments))
            .route("/feed/{id}/comments", web::post().to(dating::add_comment))
            .route("/users/{id}/block", web::post().to(dating::block))
            .route("/users/{id}/block", web::delete().to(dating::unblock))
            .route("/users/{id}/report", web::post().to(dating::report))
            .route("/ws", web::get().to(crate::module::ws::handler::ws_route)),
    );
}
