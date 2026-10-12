//! Privacy policy + terms + delete-account served by the BFF so the Play Store listing,
//! Nginx reverse proxy, and in-app Settings links always point at live HTTP 200 endpoints.

use actix_web::{web, HttpResponse};
use std::sync::Arc;

use crate::configuration::Settings;

fn page(title: &str, body: &str) -> String {
    format!(
        r#"<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>{title}</title>
<style>
body {{
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
  max-width: 760px;
  margin: 30px auto;
  padding: 24px;
  background-color: #ECE6C2;
  color: #020202;
  line-height: 1.6;
}}
.container {{
  background: #FFFFFF;
  border: 3px solid #020202;
  border-radius: 4px;
  padding: 32px;
  box-shadow: 4px 4px 0px #020202;
}}
h1, h2, h3 {{
  color: #020202;
  font-weight: 900;
  text-transform: uppercase;
  letter-spacing: -0.5px;
}}
h1 {{
  border-bottom: 3px solid #020202;
  padding-bottom: 12px;
  margin-top: 0;
}}
a {{
  color: #CC6B49;
  font-weight: 700;
  text-decoration: underline;
}}
.badge {{
  display: inline-block;
  background: #73BDA8;
  color: #020202;
  padding: 4px 10px;
  font-size: 11px;
  font-weight: 900;
  border: 2px solid #020202;
  margin-bottom: 16px;
  text-transform: uppercase;
}}
ul {{
  padding-left: 20px;
}}
li {{
  margin-bottom: 8px;
}}
.action-box {{
  background: #FAF8ED;
  border: 2px dashed #020202;
  padding: 16px;
  margin: 20px 0;
}}
</style></head><body><div class="container">{body}</div></body></html>"#
    )
}

pub async fn privacy(settings: web::Data<Arc<Settings>>) -> HttpResponse {
    let app = settings
        .legal
        .app_name
        .clone()
        .unwrap_or_else(|| "Tea Dating Advice".into());
    let company = settings
        .legal
        .company
        .clone()
        .unwrap_or_else(|| "Kraftisium".into());
    let support = settings
        .legal
        .support_email
        .clone()
        .unwrap_or_else(|| settings.email.from_email.clone());
    let body = format!(
        r#"<div class="badge">Privacy Notice</div>
<h1>{app} Privacy Policy</h1>
<p>Last updated: October 2026</p>
<h2>1. Architecture & What We Collect</h2>
<p>{app} is a candid, brutalist dating advice platform. We prioritize your privacy with minimal data collection and zero invasive device permissions.</p>
<ul>
<li><strong>Account:</strong> Name, handle, email, date of birth (to enforce the strict 18+ policy), and optionally phone number or Google account ID.</li>
<li><strong>Profile & Advice:</strong> Avatar (procedural monogram or user-uploaded avatar), bio, city, dating dilemma posts, verdicts, comments, bookmarks, and advisor rankings.</li>
<li><strong>Zero Broad Storage Permissions:</strong> We never request device camera or gallery permissions (`READ_MEDIA_IMAGES`). Profile avatars are selected strictly via the platform's permissionless Photo Picker contract.</li>
<li><strong>Direct Messages:</strong> 1-on-1 advisor consultations and replies sent via the app. Dilemmas and messages are strictly text-based.</li>
<li><strong>Device:</strong> Optional push notification token (Expo) for instant advice alerts and security rate-limiting telemetry.</li>
</ul>
<h2>2. How We Use Data</h2>
<ul>
<li>To publish anonymous or attributed dating dilemmas and deliver peer/advisor verdicts.</li>
<li>To enforce age safety (strict 18+ policy) and prevent automated spam or harassment.</li>
<li>To securely authenticate your sessions via cryptographic JSON Web Tokens.</li>
</ul>
<h2>3. Sharing & Privacy</h2>
<p>Your dilemmas, verdicts, and public advisor profile are visible to other {app} members. Private direct messages are restricted solely to you and the consulting advisor. We never sell personal data or broker user records.</p>
<h2>4. Account & Data Deletion</h2>
<p>You have full ownership of your data. You may delete your account at any time in the app via <strong>Settings &rarr; Delete Account</strong>, or through our web deletion portal at <a href="/delete-account">/delete-account</a>. Deletion immediately and irrevocably wipes your profile, handle, dilemmas, verdicts, bookmarks, and direct messages.</p>
<h2>5. 18+ Adult Policy</h2>
<p>{app} is exclusively for adults aged 18 and older. Any account discovered to be created by a minor under 18 is terminated immediately.</p>
<h2>6. Contact & Support</h2>
<p>{company} &bull; <a href="mailto:{support}">{support}</a></p>"#
    );
    HttpResponse::Ok()
        .content_type("text/html; charset=utf-8")
        .body(page(&format!("{app} Privacy Policy"), &body))
}

pub async fn terms(settings: web::Data<Arc<Settings>>) -> HttpResponse {
    let app = settings
        .legal
        .app_name
        .clone()
        .unwrap_or_else(|| "Tea Dating Advice".into());
    let support = settings
        .legal
        .support_email
        .clone()
        .unwrap_or_else(|| settings.email.from_email.clone());
    let body = format!(
        r#"<div class="badge">Community Guidelines & Terms</div>
<h1>{app} Terms of Service</h1>
<p>Last updated: October 2026</p>
<ul>
<li><strong>18+ Age Requirement:</strong> You must be 18 years of age or older to create an account or post on {app}.</li>
<li><strong>Respectful Honesty:</strong> While {app} encourages candid dating advice and brutal truth-telling, harassment, hate speech, bullying, doxxing, sexual exploitation, and spam are strictly forbidden.</li>
<li><strong>Text-Only Integrity:</strong> Impersonation or posting personal contact details / external links in dilemma descriptions to evade moderation is prohibited.</li>
<li><strong>Moderation:</strong> Use the built-in Report and Block tools to flag toxic behavior. Community moderators review all flagged advice posts and accounts.</li>
<li><strong>Questions:</strong> Contact our team at <a href="mailto:{support}">{support}</a>.</li>
</ul>"#
    );
    HttpResponse::Ok()
        .content_type("text/html; charset=utf-8")
        .body(page(&format!("{app} Terms"), &body))
}

pub async fn delete_account(settings: web::Data<Arc<Settings>>) -> HttpResponse {
    let app = settings
        .legal
        .app_name
        .clone()
        .unwrap_or_else(|| "Tea Dating Advice".into());
    let company = settings
        .legal
        .company
        .clone()
        .unwrap_or_else(|| "Kraftisium".into());
    let support = settings
        .legal
        .support_email
        .clone()
        .unwrap_or_else(|| settings.email.from_email.clone());
    let body = format!(
        r#"<div class="badge">Data Rights & Privacy</div>
<h1>Delete Your {app} Account</h1>
<p>In compliance with Google Play Store data safety standards and GDPR/CCPA privacy rights, you have the right to request full, permanent deletion of your {app} account and all associated records.</p>

<div class="action-box">
  <h3>Option 1: In-App Instant Deletion (Recommended)</h3>
  <ol>
    <li>Open the <strong>{app}</strong> application on your mobile device.</li>
    <li>Navigate to the <strong>Profile (Me)</strong> tab and tap the <strong>Settings</strong> gear icon.</li>
    <li>Scroll to the bottom and tap <span style="color:#CC6B49; font-weight:900;">Delete Account</span>.</li>
    <li>Confirm the prompt. Your profile, handle, posts, verdicts, and messages are permanently purged from our database immediately.</li>
  </ol>
</div>

<div class="action-box">
  <h3>Option 2: Web Deletion Request</h3>
  <p>If you have uninstalled the app or lost access to your device, email our support team directly:</p>
  <p><strong>Email:</strong> <a href="mailto:{support}?subject={app}%20Account%20Deletion%20Request">{support}</a></p>
  <p>Subject: <code>{app} Account Deletion Request</code></p>
  <p>Please include your registered email address or handle. Our team will verify ownership and complete the permanent deletion within 48 hours.</p>
</div>

<h2>What Data is Deleted?</h2>
<ul>
  <li>User identity (email, password hash, handle, and profile name).</li>
  <li>All posted dating dilemmas, comments, and spilled tea.</li>
  <li>All verdict votes (red flags, green flags, valid) and saved bookmarks.</li>
  <li>All 1-on-1 advisor chat threads and private consultations.</li>
  <li>All device push tokens and active login sessions.</li>
</ul>

<p>{company} &bull; Dedicated to User Privacy & Safety</p>"#
    );
    HttpResponse::Ok()
        .content_type("text/html; charset=utf-8")
        .body(page(&format!("{app} Account Deletion"), &body))
}

pub async fn safety(settings: web::Data<Arc<Settings>>) -> HttpResponse {
    let app = settings
        .legal
        .app_name
        .clone()
        .unwrap_or_else(|| "Tea Dating Advice".into());
    let company = settings
        .legal
        .company
        .clone()
        .unwrap_or_else(|| "Kraftisium".into());
    let support = settings
        .legal
        .support_email
        .clone()
        .unwrap_or_else(|| settings.email.from_email.clone());
    let body = format!(
        r#"<div class="badge">Safety & Protection Standards</div>
<h1>Child Safety & CSAE Prevention Policy</h1>
<p>Last updated: October 2026</p>
<p><strong>{app}</strong> and {company} enforce a strict, zero-tolerance policy against Child Sexual Abuse Material (CSAM), Child Sexual Exploitation and Abuse (CSAE), and any form of minor endangerment.</p>

<h2>1. Strict 18+ Adult Policy</h2>
<p>{app} is exclusively intended and legally restricted to adults aged 18 and older. We enforce strict age verification upon account creation. Any account identified as belonging to or created by a minor under the age of 18 is terminated immediately without notice, and all associated content is permanently purged.</p>

<h2>2. Text-Based Discussions & Strict Media Safeguards</h2>
<p>To safeguard user privacy and eliminate vector risks for illegal media distribution, {app} strictly enforces safety controls:</p>
<ul>
  <li>Zero device camera or broad gallery storage permissions requested.</li>
  <li>Feed dilemmas, comments, and direct messages are strictly text-based; photo/video attachments are prohibited.</li>
  <li>Profile avatars are strictly limited to user headshots or procedural monograms, with immediate 1-tap reporting and moderation.</li>
</ul>

<h2>3. In-App Reporting & Rapid Response Moderation</h2>
<p>Every advice post, comment, and direct message within {app} provides an immediate, 1-tap <strong>Report</strong> action. All safety flags are escalated directly to our moderation team with priority handling.</p>

<h2>4. Law Enforcement & NCMEC Cooperation</h2>
<p>We strictly comply with all relevant child protection legislation. Any suspected incident involving CSAE or minor endangerment is immediately reported to the National Center for Missing & Exploited Children (NCMEC) and appropriate regional law enforcement authorities.</p>

<h2>5. Contact Our Safety Team</h2>
<p>For inquiries or urgent reports regarding child safety, email our dedicated trust & safety team: <a href="mailto:{support}">{support}</a></p>
<p>{company} &bull; User Trust & Safety Officer</p>"#
    );
    HttpResponse::Ok()
        .content_type("text/html; charset=utf-8")
        .body(page(&format!("{app} Child Safety Standards"), &body))
}
