import StaticPageLayout from '../components/StaticPageLayout';
import { APP_NAME } from '../constants/brand';
import { SUPPORT_EMAIL } from '../constants/site';

export default function DeleteAccountPage() {
  return (
    <StaticPageLayout
      title="Delete your account"
      description={`How to request deletion of your ${APP_NAME} account and what happens to your data.`}
      maxWidth="lg">
      <h1 className="text-4xl font-bold text-center mb-2 text-[#DD88CF]">Delete your account</h1>
      <p className="text-center text-white/50 text-sm mb-10">
        Applies to the {APP_NAME} mobile app on Android and iOS.
      </p>

      <div className="space-y-6 text-white/85">
        <section>
          <h2 className="text-xl font-bold text-[#DD88CF]">Option 1: In the app (instant self-service)</h2>
          <ol className="list-decimal list-inside space-y-2 mt-2">
            <li>Open the <strong>{APP_NAME}</strong> app and sign in to your account.</li>
            <li>Navigate to the <strong>Settings</strong> tab (gear icon on profile).</li>
            <li>Scroll down and tap <strong>Delete account</strong>.</li>
            <li>Confirm your decision when prompted.</li>
          </ol>
          <p className="mt-2 text-white/60 text-sm">
            Your account is deleted immediately. You will be signed out, and all profile data, photos, swipes, matches, and chats are permanently erased.
          </p>
        </section>

        <section>
          <h2 className="text-xl font-bold text-[#DD88CF]">Option 2: Can&apos;t log in or app uninstalled?</h2>
          <p>
            Email{' '}
            <a href={`mailto:${SUPPORT_EMAIL}?subject=Delete my Tea account`} className="text-[#DD88CF] hover:underline">
              {SUPPORT_EMAIL}
            </a>{' '}
            from the email address associated with your account. We will verify your identity and purge your account data within 48 hours.
          </p>
        </section>

        <section>
          <h2 className="text-xl font-bold text-[#DD88CF]">What gets deleted</h2>
          <p>Upon deleting your account:</p>
          <ul className="list-disc list-inside space-y-2 mt-2">
            <li>Your account credentials, authentication tokens, and profile are completely deleted.</li>
            <li>All uploaded profile photos and media are removed from our storage servers.</li>
            <li>All your swipes, mutual matches, conversation threads, and chat messages are permanently deleted.</li>
            <li>Your device push notification tokens are revoked and deleted.</li>
          </ul>
        </section>

        <section>
          <h2 className="text-xl font-bold text-[#DD88CF]">Questions & Support</h2>
          <p>
            If you have any questions or encounter issues deleting your account, contact our support team at{' '}
            <a href={`mailto:${SUPPORT_EMAIL}`} className="text-[#DD88CF] hover:underline">
              {SUPPORT_EMAIL}
            </a>.
          </p>
        </section>
      </div>
    </StaticPageLayout>
  );
}

