use actix_cors::Cors;
use actix_web::http::header;

pub fn configure_cors(frontend_base_url: String) -> Cors {
    let prod_origin = frontend_base_url.trim_end_matches('/').to_string();
    Cors::default()
        .allowed_origin_fn(move |origin, _| {
            let o = origin.to_str().unwrap_or("");
            // Dev: allow any localhost or 127.0.0.1 origin (any port)
            if o.starts_with("http://localhost") || o.starts_with("http://127.0.0.1") {
                return true;
            }
            // Prod: exact match only — prevents starts_with("https://tea.kraftisium.xyz.attacker.com")
            if !prod_origin.is_empty() && o == prod_origin {
                return true;
            }
            false
        })

        .allowed_methods(vec!["GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"])
        .allowed_headers(vec![
            header::AUTHORIZATION,
            header::ACCEPT,
            header::CONTENT_TYPE,
        ])
        .supports_credentials()
        .max_age(3600)
}
