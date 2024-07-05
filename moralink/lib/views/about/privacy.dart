import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moralink/themes/colors.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/user_provider.dart';
import '../../shared/widgets/responsive_layout.dart';
import '../widget/app_drawer.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return ResponsiveLayout(
      mobileBody: _buildPrivacyContent(context, textTheme, isDarkMode,
          constraints: const BoxConstraints(maxWidth: 600)),
      tabletBody: _buildPrivacyContent(context, textTheme, isDarkMode,
          constraints: const BoxConstraints(maxWidth: 800)),
      desktopBody: _buildPrivacyContent(context, textTheme, isDarkMode,
          constraints: const BoxConstraints(maxWidth: 1200)),
    );
  }

  Widget _buildPrivacyContent(
      BuildContext context, TextTheme textTheme, bool isDarkMode,
      {required BoxConstraints constraints}) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Privacy Policy',
                    style: textTheme.headlineLarge?.copyWith(
                      color: isDarkMode ? AppColors.accent : null,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Last updated: June 26, 2024',
                    style: textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'This Privacy Policy describes Our policies and procedures on the collection, use and disclosure of Your information when You use the Service and tells You about Your privacy rights and how the law protects You.',
                    style: textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'We use Your Personal data to provide and improve the Service. By using the Service, You agree to the collection and use of information in accordance with this Privacy Policy.',
                    style: textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Interpretation and Definitions',
                    style: textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Interpretation',
                    style: textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'The words of which the initial letter is capitalized have meanings defined under the following conditions. The following definitions shall have the same meaning regardless of whether they appear in singular or in plural.',
                    style: textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Definitions',
                    style: textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'For the purposes of this Privacy Policy:',
                    style: textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  _buildDefinitionList(textTheme),
                  const SizedBox(height: 32),
                  _buildCollectingAndUsingPersonalData(textTheme),
                  const SizedBox(height: 32),
                  _buildThirdPartyAndTrackingInfo(textTheme),
                  const SizedBox(height: 32),
                  _buildUseOfPersonalData(textTheme),
                  const SizedBox(height: 32),
                  _buildDataRetentionTransferDeletion(textTheme),
                  const SizedBox(height: 32),
                  _buildDisclosureOfPersonalData(textTheme),
                  const SizedBox(height: 32),
                  _buildSecurityOfPersonalData(textTheme),
                  const SizedBox(height: 32),
                  _buildChildrensPrivacy(textTheme),
                  const SizedBox(height: 32),
                  _buildLinkToOtherWebsite(textTheme),
                  const SizedBox(height: 32),
                  _buildChangeToThisPolicy(textTheme),
                  const SizedBox(height: 32),
                  Text(
                    'Contact Us',
                    style: textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'If you have any questions about this Privacy Policy, You can contact us:',
                    style: textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'By email: inthad.yu@gmail.com',
                    style: textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
      drawer: AppDrawer(
        authProvider: authProvider,
        userProvider: userProvider,
      ),
    );
  }

  Widget _buildDefinitionList(TextTheme textTheme) {
    final definitions = [
      {
        'term': 'Account',
        'definition':
            'means a unique account created for You to access our Service or parts of our Service.'
      },
      {
        'term': 'Affiliate',
        'definition':
            'means an entity that controls, is controlled by or is under common control with a party, where "control" means ownership of 50% or more of the shares, equity interest or other securities entitled to vote for election of directors or other managing authority.'
      },
      {
        'term': 'Company',
        'definition':
            '(referred to as either "the Company", "We", "Us" or "Our" in this Agreement) refers to Moralink.'
      },
      {
        'term': 'Cookies',
        'definition':
            'are small files that are placed on Your computer, mobile device or any other device by a website, containing the details of Your browsing history on that website among its many uses.'
      },
      {'term': 'Country', 'definition': 'refers to: Thailand'},
      {
        'term': 'Device',
        'definition':
            'means any device that can access the Service such as a computer, a cellphone or a digital tablet.'
      },
      {
        'term': 'Personal Data',
        'definition':
            'is any information that relates to an identified or identifiable individual.'
      },
      {'term': 'Service', 'definition': 'refers to the Website.'},
      {
        'term': 'Service Provider',
        'definition':
            'means any natural or legal person who processes the data on behalf of the Company. It refers to third-party companies or individuals employed by the Company to facilitate the Service, to provide the Service on behalf of the Company, to perform services related to the Service or to assist the Company in analyzing how the Service is used.'
      },
      {
        'term': 'Third-party Social Media Service',
        'definition':
            'refers to any website or any social network website through which a User can log in or create an account to use the Service.'
      },
      {
        'term': 'Usage Data',
        'definition':
            'refers to data collected automatically, either generated by the use of the Service or from the Service infrastructure itself (for example, the duration of a page visit).'
      },
      {
        'term': 'Website',
        'definition':
            'refers to Moralink, accessible from https://moralink.lemonsensei.dev/'
      },
      {
        'term': 'You',
        'definition':
            'means the individual accessing or using the Service, or the company, or other legal entity on behalf of which such individual is accessing or using the Service, as applicable.'
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: definitions
          .map((def) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: RichText(
                  text: TextSpan(
                    style: textTheme.bodyMedium,
                    children: [
                      TextSpan(
                          text: '${def['term']}: ',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: def['definition']),
                    ],
                  ),
                ),
              ))
          .toList(),
    );
  }

  Widget _buildCollectingAndUsingPersonalData(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Collecting and Using Your Personal Data',
          style: textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        Text(
          'Types of Data Collected',
          style: textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Text(
          'Personal Data',
          style: textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Text(
          'While using Our Service, We may ask You to provide Us with certain personally identifiable information that can be used to contact or identify You. Personally identifiable information may include, but is not limited to:',
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('• Email address', style: textTheme.bodyMedium),
            Text('• First name and last name', style: textTheme.bodyMedium),
            Text('• Phone number', style: textTheme.bodyMedium),
            Text('• Address, State, Province, ZIP/Postal code, City',
                style: textTheme.bodyMedium),
            Text('• Usage Data', style: textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Usage Data',
          style: textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Text(
          'Usage Data is collected automatically when using the Service.',
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 8),
        Text(
          'Usage Data may include information such as Your Device\'s Internet Protocol address (e.g. IP address), browser type, browser version, the pages of our Service that You visit, the time and date of Your visit, the time spent on those pages, unique device identifiers and other diagnostic data.',
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 8),
        Text(
          'When You access the Service by or through a mobile device, We may collect certain information automatically, including, but not limited to, the type of mobile device You use, Your mobile device unique ID, the IP address of Your mobile device, Your mobile operating system, the type of mobile Internet browser You use, unique device identifiers and other diagnostic data.',
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 8),
        Text(
          'We may also collect information that Your browser sends whenever You visit our Service or when You access the Service by or through a mobile device.',
          style: textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildThirdPartyAndTrackingInfo(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Information from Third-Party Social Media Services',
          style: textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Text(
          'The Company allows You to create an account and log in to use the Service through the following Third-party Social Media Services:',
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('• Google', style: textTheme.bodyMedium),
            Text('• Facebook', style: textTheme.bodyMedium),
            Text('• Instagram', style: textTheme.bodyMedium),
            Text('• Twitter', style: textTheme.bodyMedium),
            Text('• LinkedIn', style: textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'If You decide to register through or otherwise grant us access to a Third-Party Social Media Service, We may collect Personal data that is already associated with Your Third-Party Social Media Service\'s account, such as Your name, Your email address, Your activities or Your contact list associated with that account.',
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        Text(
          'You may also have the option of sharing additional information with the Company through Your Third-Party Social Media Service\'s account. If You choose to provide such information and Personal Data, during registration or otherwise, You are giving the Company permission to use, share, and store it in a manner consistent with this Privacy Policy.',
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 32),
        Text(
          'Tracking Technologies and Cookies',
          style: textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Text(
          'We use Cookies and similar tracking technologies to track the activity on Our Service and store certain information. Tracking technologies used are beacons, tags, and scripts to collect and track information and to improve and analyze Our Service. The technologies We use may include:',
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                '• Cookies or Browser Cookies: A cookie is a small file placed on Your Device. You can instruct Your browser to refuse all Cookies or to indicate when a Cookie is being sent. However, if You do not accept Cookies, You may not be able to use some parts of our Service. Unless you have adjusted Your browser setting so that it will refuse Cookies, our Service may use Cookies.',
                style: textTheme.bodyMedium),
            const SizedBox(height: 8),
            Text(
                '• Web Beacons: Certain sections of our Service and our emails may contain small electronic files known as web beacons (also referred to as clear gifs, pixel tags, and single-pixel gifs) that permit the Company, for example, to count users who have visited those pages or opened an email and for other related website statistics (for example, recording the popularity of a certain section and verifying system and server integrity).',
                style: textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Cookies can be "Persistent" or "Session" Cookies. Persistent Cookies remain on Your personal computer or mobile device when You go offline, while Session Cookies are deleted as soon as You close Your web browser.',
          style: textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildUseOfPersonalData(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Use of Your Personal Data',
          style: textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        Text(
          'The Company may use Personal Data for the following purposes:',
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBulletPoint(textTheme,
                'To provide and maintain our Service, including to monitor the usage of our Service.'),
            _buildBulletPoint(textTheme,
                'To manage Your Account: to manage Your registration as a user of the Service. The Personal Data You provide can give You access to different functionalities of the Service that are available to You as a registered user.'),
            _buildBulletPoint(textTheme,
                'For the performance of a contract: the development, compliance and undertaking of the purchase contract for the products, items or services You have purchased or of any other contract with Us through the Service.'),
            _buildBulletPoint(textTheme,
                'To contact You: To contact You by email, telephone calls, SMS, or other equivalent forms of electronic communication, such as a mobile application\'s push notifications regarding updates or informative communications related to the functionalities, products or contracted services, including the security updates, when necessary or reasonable for their implementation.'),
            _buildBulletPoint(textTheme,
                'To provide You with news, special offers and general information about other goods, services and events which we offer that are similar to those that you have already purchased or enquired about unless You have opted not to receive such information.'),
            _buildBulletPoint(textTheme,
                'To manage Your requests: To attend and manage Your requests to Us.'),
            _buildBulletPoint(textTheme,
                'For business transfers: We may use Your information to evaluate or conduct a merger, divestiture, restructuring, reorganization, dissolution, or other sale or transfer of some or all of Our assets, whether as a going concern or as part of bankruptcy, liquidation, or similar proceeding, in which Personal Data held by Us about our Service users is among the assets transferred.'),
            _buildBulletPoint(textTheme,
                'For other purposes: We may use Your information for other purposes, such as data analysis, identifying usage trends, determining the effectiveness of our promotional campaigns and to evaluate and improve our Service, products, services, marketing and your experience.'),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'We may share Your personal information in the following situations:',
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBulletPoint(textTheme,
                'With Service Providers: We may share Your personal information with Service Providers to monitor and analyze the use of our Service, to contact You.'),
            _buildBulletPoint(textTheme,
                'For business transfers: We may share or transfer Your personal information in connection with, or during negotiations of, any merger, sale of Company assets, financing, or acquisition of all or a portion of Our business to another company.'),
            _buildBulletPoint(textTheme,
                'With Affiliates: We may share Your information with Our affiliates, in which case we will require those affiliates to honor this Privacy Policy. Affiliates include Our parent company and any other subsidiaries, joint venture partners or other companies that We control or that are under common control with Us.'),
            _buildBulletPoint(textTheme,
                'With business partners: We may share Your information with Our business partners to offer You certain products, services or promotions.'),
            _buildBulletPoint(textTheme,
                'With other users: when You share personal information or otherwise interact in the public areas with other users, such information may be viewed by all users and may be publicly distributed outside.'),
            _buildBulletPoint(textTheme,
                'With Your consent: We may disclose Your personal information for any other purpose with Your consent.'),
          ],
        ),
      ],
    );
  }

  Widget _buildBulletPoint(TextTheme textTheme, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: textTheme.bodyMedium),
          Expanded(
            child: Text(text, style: textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }

  Widget _buildDataRetentionTransferDeletion(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Retention of Your Personal Data',
          style: textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        Text(
          'The Company will retain Your Personal Data only for as long as is necessary for the purposes set out in this Privacy Policy. We will retain and use Your Personal Data to the extent necessary to comply with our legal obligations (for example, if we are required to retain your data to comply with applicable laws), resolve disputes, and enforce our legal agreements and policies.',
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        Text(
          'The Company will also retain Usage Data for internal analysis purposes. Usage Data is generally retained for a shorter period of time, except when this data is used to strengthen the security or to improve the functionality of Our Service, or We are legally obligated to retain this data for longer time periods.',
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 32),
        Text(
          'Transfer of Your Personal Data',
          style: textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        Text(
          'Your information, including Personal Data, is processed at the Company\'s operating offices and in any other places where the parties involved in the processing are located. It means that this information may be transferred to — and maintained on — computers located outside of Your state, province, country or other governmental jurisdiction where the data protection laws may differ than those from Your jurisdiction.',
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        Text(
          'Your consent to this Privacy Policy followed by Your submission of such information represents Your agreement to that transfer.',
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        Text(
          'The Company will take all steps reasonably necessary to ensure that Your data is treated securely and in accordance with this Privacy Policy and no transfer of Your Personal Data will take place to an organization or a country unless there are adequate controls in place including the security of Your data and other personal information.',
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 32),
        Text(
          'Delete Your Personal Data',
          style: textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        Text(
          'You have the right to delete or request that We assist in deleting the Personal Data that We have collected about You.',
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        Text(
          'Our Service may give You the ability to delete certain information about You from within the Service.',
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        Text(
          'You may update, amend, or delete Your information at any time by signing in to Your Account, if you have one, and visiting the account settings section that allows you to manage Your personal information. You may also contact Us to request access to, correct, or delete any personal information that You have provided to Us.',
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        Text(
          'Please note, however, that We may need to retain certain information when we have a legal obligation or lawful basis to do so.',
          style: textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildDisclosureOfPersonalData(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Disclosure of Your Personal Data',
          style: textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        Text(
          'Business Transactions',
          style: textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Text(
          'If the Company is involved in a merger, acquisition or asset sale, Your Personal Data may be transferred. We will provide notice before Your Personal Data is transferred and becomes subject to a different Privacy Policy.',
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        Text(
          'Law enforcement',
          style: textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Text(
          'Under certain circumstances, the Company may be required to disclose Your Personal Data if required to do so by law or in response to valid requests by public authorities (e.g. a court or a government agency).',
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        Text(
          'Other legal requirements',
          style: textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Text(
          'The Company may disclose Your Personal Data in the good faith belief that such action is necessary to:',
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBulletPoint(textTheme, 'Comply with a legal obligation'),
            _buildBulletPoint(textTheme,
                'Protect and defend the rights or property of the Company'),
            _buildBulletPoint(textTheme,
                'Prevent or investigate possible wrongdoing in connection with the Service'),
            _buildBulletPoint(textTheme,
                'Protect the personal safety of Users of the Service or the public'),
            _buildBulletPoint(textTheme, 'Protect against legal liability'),
          ],
        ),
      ],
    );
  }

  Widget _buildSecurityOfPersonalData(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Security of Your Personal Data',
          style: textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        Text(
          'The security of Your Personal Data is important to Us, but remember that no method of transmission over the Internet, or method of electronic storage is 100% secure. While We strive to use commercially acceptable means to protect Your Personal Data, We cannot guarantee its absolute security.',
          style: textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildChildrensPrivacy(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Children\'s Privacy',
          style: textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        Text(
          'Our Service does not address anyone under the age of 13. We do not knowingly collect personally identifiable information from anyone under the age of 13. If You are a parent or guardian and You are aware that Your child has provided Us with Personal Data, please contact Us. If We become aware that We have collected Personal Data from anyone under the age of 13 without verification of parental consent, We take steps to remove that information from Our servers.',
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        Text(
          'If We need to rely on consent as a legal basis for processing Your information and Your country requires consent from a parent, We may require Your parent\'s consent before We collect and use that information.',
          style: textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildLinkToOtherWebsite(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Links to Other Websites',
          style: textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        Text(
          'Our Service may contain links to other websites that are not operated by Us. If You click on a third party link, You will be directed to that third party\'s site. We strongly advise You to review the Privacy Policy of every site You visit.',
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        Text(
          'We have no control over and assume no responsibility for the content, privacy policies or practices of any third party sites or services.',
          style: textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildChangeToThisPolicy(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Changes to this Privacy Policy',
          style: textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        Text(
          'We may update Our Privacy Policy from time to time. We will notify You of any changes by posting the new Privacy Policy on this page.',
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        Text(
          'We will let You know via email and/or a prominent notice on Our Service, prior to the change becoming effective and update the "Last updated" date at the top of this Privacy Policy.',
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        Text(
          'You are advised to review this Privacy Policy periodically for any changes. Changes to this Privacy Policy are effective when they are posted on this page.',
          style: textTheme.bodyMedium,
        ),
      ],
    );
  }
}
