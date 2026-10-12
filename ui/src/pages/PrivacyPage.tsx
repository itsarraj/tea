import { Link } from 'react-router-dom';
import StaticPageLayout from '../components/StaticPageLayout';
import { APP_NAME } from '../constants/brand';
import { SUPPORT_EMAIL, SITE_URL } from '../constants/site';

export default function PrivacyPage() {
  const updated = 'September 27, 2026';

  return (
    <StaticPageLayout
      title="Privacy Policy"
      description={`How ${APP_NAME} collects, uses, and protects your data.`}
      maxWidth="lg">
      <h1 className="text-4xl font-bold text-center mb-2 text-[#DD88CF]">{APP_NAME} Privacy Policy</h1>
      <p className="text-center text-white/50 text-sm mb-10">Last updated: {updated}</p>

      <div className="space-y-6 text-white/85">
        <p>
          {APP_NAME} (&ldquo;we&rdquo;, &ldquo;our&rdquo;, or &ldquo;us&rdquo;), operated at {SITE_URL}, is committed to protecting your privacy. This Privacy Policy describes how we collect, use, store, and protect your information when you use our mobile application and related services.
        </p>

        <section>
          <h2 className="text-xl font-bold text-[#DD88CF]">1. Information We Collect</h2>
          <ul className="list-disc list-inside space-y-2 mt-2">
            <li><strong>Account & Identity:</strong> Name, email address, phone number (if signing in via SMS), Google ID (if signing in via Google), password hash, and date of birth (to enforce our strict 18+ age policy).</li>
            <li><strong>Profile & Preferences:</strong> Profile photos uploaded from your camera or photo library, bio, gender, discovery preferences (dating or friends/BFF), occupation, university, height, languages, lifestyle traits, and interests.</li>
            <li><strong>Location Data:</strong> Approximate and precise location (accessed only while using the app with your permission) to calculate distance and show members nearby. We do not track your location in the background.</li>
            <li><strong>Messages & Interactions:</strong> Swipes (likes and passes), mutual matches, in-app direct messages, feed posts, comments, likes, and stories shared on the platform.</li>
            <li><strong>Device & Technical Data:</strong> Push notification tokens (for match and message alerts), IP address, app version, and basic device metrics used exclusively for security, anti-abuse, and rate limiting.</li>
          </ul>
        </section>

        <section>
          <h2 className="text-xl font-bold text-[#DD88CF]">2. How We Use Your Information</h2>
          <ul className="list-disc list-inside space-y-2 mt-2">
            <li><strong>Core App Functionality:</strong> To authenticate your account, showcase your profile to compatible members nearby, facilitate mutual matching, and deliver in-app chat.</li>
            <li><strong>Safety & Community Moderation:</strong> To verify that all members are 18+, investigate abuse, and enforce safety actions (such as blocking and reporting inappropriate accounts).</li>
            <li><strong>Notifications:</strong> To send real-time alerts about new matches, incoming messages, and account updates (controllable via your device notification settings).</li>
            <li><strong>Platform Security:</strong> To protect our community from fraud, spam, unauthorized access, and malicious attacks.</li>
          </ul>
        </section>

        <section>
          <h2 className="text-xl font-bold text-[#DD88CF]">3. Information Sharing & Third Parties</h2>
          <p>
            We respect your personal privacy. <strong>We do not sell, rent, or trade your personal data to third parties.</strong> We do not embed third-party advertising SDKs or tracking networks.
          </p>
          <ul className="list-disc list-inside space-y-2 mt-2">
            <li><strong>Other Members:</strong> Your public profile (photos, first name, age, city, distance, bio, and interests) is visible to other members on {APP_NAME}. In-app messages are private between you and your mutual match.</li>
            <li><strong>Service Providers:</strong> We use reputable cloud infrastructure, database hosting, SMS/email verification, and push notification providers under confidentiality agreements solely to operate the service.</li>
            <li><strong>Legal Compliance:</strong> We may disclose information if required by applicable law, court order, or to protect the vital safety of individuals.</li>
          </ul>
        </section>

        <section>
          <h2 className="text-xl font-bold text-[#DD88CF]">4. Data Retention & Account Deletion</h2>
          <p>
            We retain your data only for as long as your account remains active. You maintain complete control over your personal data:
          </p>
          <ul className="list-disc list-inside space-y-2 mt-2">
            <li><strong>In-App Deletion:</strong> You can delete your account at any time directly in the mobile app by navigating to <strong>Settings &rarr; Delete account</strong>.</li>
            <li><strong>Web Deletion Request:</strong> You can also submit an account deletion request via our <Link to="/delete-account" className="text-[#DD88CF] hover:underline">Account Deletion Page</Link> or by emailing <a href={`mailto:${SUPPORT_EMAIL}?subject=Account Deletion Request`} className="text-[#DD88CF] hover:underline">{SUPPORT_EMAIL}</a>.</li>
            <li><strong>Immediate Removal:</strong> When you delete your account, your profile, photos, matches, messages, and uploaded content are permanently and irreversibly purged from our active systems.</li>
          </ul>
        </section>

        <section>
          <h2 className="text-xl font-bold text-[#DD88CF]">5. Security & Encryption</h2>
          <p>
            All data transmitted between the {APP_NAME} mobile application and our backend servers is encrypted in transit using industry-standard TLS (HTTPS). Sensitive credentials and tokens are stored securely on device using hardware-backed keychains.
          </p>
        </section>

        <section>
          <h2 className="text-xl font-bold text-[#DD88CF]">6. Children&apos;s Privacy (18+ Policy)</h2>
          <p>
            {APP_NAME} is strictly intended for individuals 18 years of age or older. We do not knowingly permit registration or collect personal information from individuals under the age of 18. Any account discovered to belong to a minor is terminated immediately.
          </p>
        </section>

        <section>
          <h2 className="text-xl font-bold text-[#DD88CF]">7. Contact & Privacy Inquiries</h2>
          <p>
            If you have questions, feedback, or wish to exercise any of your privacy rights, please contact our Data Protection team at:{' '}
            <a href={`mailto:${SUPPORT_EMAIL}`} className="text-[#DD88CF] hover:underline">
              {SUPPORT_EMAIL}
            </a>
          </p>
        </section>
      </div>
    </StaticPageLayout>
  );
}

