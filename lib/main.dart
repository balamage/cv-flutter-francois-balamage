import 'package:material_ui/material_ui.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const CvApp());
}

const _ink = Color(0xFF173B35);
const _green = Color(0xFF267A62);
const _mint = Color(0xFFE7F1EB);
const _paper = Color(0xFFF7F8F4);
const _muted = Color(0xFF69756F);
const _orange = Color(0xFFE7A45E);

class CvApp extends StatelessWidget {
  const CvApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CV — Balamage Basinyize Francois',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: _paper,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _green,
          primary: _green,
          surface: _paper,
        ),
        fontFamily: 'Roboto',
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _showCredentialsError = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signIn() {
    if (!_formKey.currentState!.validate()) return;

    if (_usernameController.text.trim() != 'admin' ||
        _passwordController.text != '1234') {
      setState(() => _showCredentialsError = true);
      return;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const PortfolioShell()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: const Color(0xFFEAF0EA)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0A173B35),
                      blurRadius: 28,
                      offset: Offset(0, 12),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      'Connexion',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            color: _ink,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.8,
                          ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Connectez-vous pour découvrir mon profil, mon parcours et mes contacts.',
                      style: TextStyle(
                        color: _muted,
                        height: 1.55,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 28),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            key: const ValueKey('username-field'),
                            controller: _usernameController,
                            textInputAction: TextInputAction.next,
                            decoration: _inputDecoration(
                              label: 'Identifiant',
                              icon: Icons.person_outline_rounded,
                            ),
                            validator: (value) => value == null || value.isEmpty
                                ? 'Saisissez votre identifiant.'
                                : null,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            key: const ValueKey('password-field'),
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) => _signIn(),
                            decoration:
                                _inputDecoration(
                                  label: 'Mot de passe',
                                  icon: Icons.lock_outline_rounded,
                                ).copyWith(
                                  suffixIcon: IconButton(
                                    tooltip: _obscurePassword
                                        ? 'Afficher le mot de passe'
                                        : 'Masquer le mot de passe',
                                    onPressed: () => setState(
                                      () =>
                                          _obscurePassword = !_obscurePassword,
                                    ),
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                    ),
                                  ),
                                ),
                            validator: (value) => value == null || value.isEmpty
                                ? 'Saisissez votre mot de passe.'
                                : null,
                          ),
                          if (_showCredentialsError) ...[
                            const SizedBox(height: 12),
                            const Text(
                              'Identifiant ou mot de passe incorrect.',
                              key: ValueKey('credentials-error'),
                              style: TextStyle(color: Color(0xFFB34335)),
                            ),
                          ],
                          const SizedBox(height: 24),
                          FilledButton(
                            key: const ValueKey('login-button'),
                            onPressed: _signIn,
                            style: FilledButton.styleFrom(
                              backgroundColor: _ink,
                              foregroundColor: Colors.white,
                              minimumSize: const Size.fromHeight(56),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text(
                              'Se connecter',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _mint,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Text.rich(
                        TextSpan(
                          style: TextStyle(color: _ink, height: 1.5),
                          children: [
                            TextSpan(
                              text: 'Accès démo  ',
                              style: TextStyle(fontWeight: FontWeight.w800),
                            ),
                            TextSpan(
                              text:
                                  'Identifiant : admin  ·  Mot de passe : 1234',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

InputDecoration _inputDecoration({
  required String label,
  required IconData icon,
}) {
  return InputDecoration(
    labelText: label,
    prefixIcon: Icon(icon, color: _green),
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Color(0xFFE4EAE5)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: _green, width: 1.5),
    ),
  );
}

class PortfolioShell extends StatefulWidget {
  const PortfolioShell({super.key});

  @override
  State<PortfolioShell> createState() => _PortfolioShellState();
}

class _PortfolioShellState extends State<PortfolioShell> {
  int _selectedIndex = 0;

  static const _pages = [ResumePage(), FamilyPage(), ContactPage()];

  static const _titles = ['Mon CV', 'Ma famille', 'Me contacter'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 24, 22, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: _mint,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(
                        Icons.person_outline_rounded,
                        color: _green,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Mon portfolio',
                      style: TextStyle(
                        color: _ink,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Parcours, famille et contact',
                      style: TextStyle(color: _muted),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              _NavigationItem(
                icon: Icons.badge_outlined,
                label: 'CV',
                selected: _selectedIndex == 0,
                onTap: () => _selectPage(context, 0),
              ),
              _NavigationItem(
                icon: Icons.groups_outlined,
                label: 'Famille',
                selected: _selectedIndex == 1,
                onTap: () => _selectPage(context, 1),
              ),
              _NavigationItem(
                icon: Icons.alternate_email_rounded,
                label: 'Contact',
                selected: _selectedIndex == 2,
                onTap: () => _selectPage(context, 2),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            key: const ValueKey('navigation-menu-button'),
            tooltip: 'Ouvrir le menu',
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: const Icon(Icons.menu_rounded, color: _ink),
          ),
        ),
        backgroundColor: _paper,
        titleSpacing: 24,
        title: Text(
          _titles[_selectedIndex],
          style: const TextStyle(
            color: _ink,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.3,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Se déconnecter',
            onPressed: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute<void>(builder: (_) => const LoginPage()),
              (_) => false,
            ),
            icon: const Icon(Icons.logout_rounded, color: _ink),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: NavigationBar(
        key: const ValueKey('bottom-navigation-bar'),
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) =>
            setState(() => _selectedIndex = index),
        backgroundColor: Colors.white,
        indicatorColor: _mint,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.badge_outlined),
            selectedIcon: Icon(Icons.badge_rounded),
            label: 'CV',
          ),
          NavigationDestination(
            icon: Icon(Icons.groups_outlined),
            selectedIcon: Icon(Icons.groups_rounded),
            label: 'Famille',
          ),
          NavigationDestination(
            icon: Icon(Icons.alternate_email_rounded),
            selectedIcon: Icon(Icons.mark_email_read_rounded),
            label: 'Contact',
          ),
        ],
      ),
    );
  }

  void _selectPage(BuildContext context, int index) {
    Navigator.of(context).pop();
    setState(() => _selectedIndex = index);
  }
}

class _NavigationItem extends StatelessWidget {
  const _NavigationItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: selected ? _green : _muted),
      title: Text(
        label,
        style: TextStyle(
          color: selected ? _green : _ink,
          fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
        ),
      ),
      selected: selected,
      selectedTileColor: _mint,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      onTap: onTap,
    );
  }
}

class ResumePage extends StatelessWidget {
  const ResumePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: const ValueKey('resume-page'),
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
      children: [
        _ProfileCard(),
        const SizedBox(height: 26),
        const _SectionTitle(title: 'I. Identité', eyebrow: 'PROFIL PERSONNEL'),
        const SizedBox(height: 12),
        const _IdentityCard(),
        const SizedBox(height: 24),
        const _SectionTitle(
          title: 'II. Études faites',
          eyebrow: 'MON PARCOURS',
        ),
        const SizedBox(height: 12),
        const _TimelineCard(
          icon: Icons.school_outlined,
          title: 'Formation en informatique',
          subtitle: 'Etudiant en LIC3LIAGE à ISIG/GOMA',
          description:
              'Développement logiciel, bases de données, systèmes et réseaux.',
        ),
        const SizedBox(height: 24),
        const _SectionTitle(title: 'III. Expériences', eyebrow: 'EN PRATIQUE'),
        const SizedBox(height: 12),
        const _TimelineCard(
          icon: Icons.code_rounded,
          title: 'Projets personnels',
          subtitle: 'Réalisations des application',
          description: 'Applications web et mobiles, interfaces accessibles et outils numériques.',
        ),
        const SizedBox(height: 24),
        const _SectionTitle(
          title: 'IV. Langues parlées',
          eyebrow: 'COMMUNICATION',
        ),
        const SizedBox(height: 12),
        const _LanguagesCard(),
      ],
    );
  }
}

class _IdentityCard extends StatelessWidget {
  const _IdentityCard();

  @override
  Widget build(BuildContext context) {
    const List<(String, String)> fields = [
      ('Nom', 'BALAMAGE'),
      ('Post nom', 'BASINYIZE'),
      ('Prénom', 'FRANCOIS'),
      ('Sexe', 'Masculin'),
      ('Lieu de naissance', 'MINOVA'),
      ('Date de naissance', '24 Janvier 2006'),
    ];

    return _PaperCard(
      child: Column(
        children: [
          for (var index = 0; index < fields.length; index++) ...[
            if (index > 0) const Divider(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    fields[index].$1,
                    style: const TextStyle(
                      color: _muted,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  fields[index].$2,
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    color: _ink,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _LanguagesCard extends StatelessWidget {
  const _LanguagesCard();

  @override
  Widget build(BuildContext context) {
    return const _PaperCard(
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          _LanguageChip(label: 'Français'),
          _LanguageChip(label: 'Anglais'),
        ],
      ),
    );
  }
}

class _LanguageChip extends StatelessWidget {
  const _LanguageChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: _mint,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: _ink,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _ink,
        borderRadius: BorderRadius.circular(26),
        image: const DecorationImage(
          image: AssetImage('assets/images/profile.jpg'),
          alignment: Alignment.centerRight,
          fit: BoxFit.cover,
          opacity: 0.1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Image.asset(
              'assets/images/profile.jpg',
              key: const ValueKey('profile-photo'),
              width: 140,
              height: 170,
              fit: BoxFit.cover,
              alignment: const Alignment(0, -0.12),
              semanticLabel: 'Photo de profil d’Auriol Basinyize',
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'AURIOL BASINYIZE',
            style: TextStyle(
              color: Color(0xFFB8DFC7),
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            'Développeur &\nadministrateur',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              height: 1.12,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.7,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Curieux, rigoureux et motivé par la création de solutions numériques utiles.',
            style: TextStyle(color: Color(0xFFD8E5DC), height: 1.5),
          ),
          const SizedBox(height: 18),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _Badge(label: 'Mobile'),
              _Badge(label: 'Web'),
              _Badge(label: 'Systèmes'),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.eyebrow});

  final String title;
  final String eyebrow;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          eyebrow,
          style: const TextStyle(
            color: _green,
            fontSize: 10,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.8,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: _ink,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }
}

class _TimelineCard extends StatelessWidget {
  const _TimelineCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String description;

  @override
  Widget build(BuildContext context) {
    return _PaperCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _IconTile(icon: icon),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: _ink,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: _green,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: const TextStyle(color: _muted, height: 1.45),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FamilyPage extends StatelessWidget {
  const FamilyPage({super.key});

  static const _members = [
    _FamilyMember(
      name: 'Elon Musk',
      relation: 'Père · rôle de maquette',
      image: 'assets/images/elon_musk.jpg',
      icon: Icons.rocket_launch_rounded,
      color: Color(0xFFECE8F7),
    ),
    _FamilyMember(
      name: 'Kim Kardashian',
      relation: 'Mère · rôle de maquette',
      image: 'assets/images/kim_kardashian.jpg',
      icon: Icons.star_rounded,
      color: Color(0xFFF8E9E4),
    ),
    _FamilyMember(
      name: 'Bill Gates',
      relation: 'Oncle · rôle de maquette',
      image: 'assets/images/bill_gates.jpg',
      icon: Icons.lightbulb_outline_rounded,
      color: Color(0xFFE8F0F6),
    ),
    _FamilyMember(
      name: 'Justin Bieber',
      relation: 'Ami',
      image: 'assets/images/justin_bieber.jpg',
      icon: Icons.music_note_rounded,
      color: Color(0xFFF8F0DD),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: const ValueKey('family-page'),
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
      children: [
        const Text(
          'Les personnes qui comptent',
          style: TextStyle(
            color: _ink,
            fontSize: 21,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.7,
          ),
        ),
        const SizedBox(height: 7),
        const Text(
          'Une galerie de proches et de personnalités inspirantes.',
          style: TextStyle(color: _muted, height: 1.4),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF2E0),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info_outline_rounded,
                color: Color(0xFF9A632F),
                size: 18,
              ),
              SizedBox(width: 9),
              Expanded(
                child: Text(
                  'Les liens père, mère et oncle sont fictifs et présentés comme une maquette, à la demande du propriétaire du CV.',
                  style: TextStyle(
                    color: Color(0xFF795431),
                    height: 1.4,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        for (final member in _members) ...[
          _FamilyCard(member: member),
          const SizedBox(height: 14),
        ],
      ],
    );
  }
}

class _FamilyMember {
  const _FamilyMember({
    required this.name,
    required this.relation,
    required this.image,
    required this.icon,
    required this.color,
  });

  final String name;
  final String relation;
  final String image;
  final IconData icon;
  final Color color;
}

class _FamilyCard extends StatelessWidget {
  const _FamilyCard({required this.member});

  final _FamilyMember member;

  @override
  Widget build(BuildContext context) {
    return _PaperCard(
      padding: EdgeInsets.zero,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(20),
            ),
            child: Image.asset(
              member.image,
              width: 112,
              height: 136,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                width: 112,
                height: 136,
                color: member.color,
                child: Icon(member.icon, color: _ink, size: 34),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    member.relation.toUpperCase(),
                    style: const TextStyle(
                      color: _green,
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    member.name,
                    style: const TextStyle(
                      color: _ink,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Portrait fourni par Wikimedia Commons.',
                    style: TextStyle(color: _muted, fontSize: 11, height: 1.35),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 4),
        ],
      ),
    );
  }
}

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: const ValueKey('contact-page'),
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
      children: [
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: _ink,
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.waving_hand_rounded, color: _orange, size: 28),
              SizedBox(height: 16),
              Text(
                'Parlons de votre projet.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  height: 1.15,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.6,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Pour une collaboration, une question ou simplement échanger.',
                style: TextStyle(color: Color(0xFFD8E5DC), height: 1.5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const _SectionTitle(
          title: 'Mes coordonnées',
          eyebrow: 'RESTONS EN CONTACT',
        ),
        const SizedBox(height: 14),
        _ContactTile(
          icon: Icons.phone_outlined,
          label: 'TÉLÉPHONE',
          value: '+243 995 082 693',
          uri: Uri(scheme: 'tel', path: '+243995082693'),
        ),
        const SizedBox(height: 12),
        _ContactTile(
          icon: Icons.mail_outline_rounded,
          label: 'E-MAIL',
          value: 'auriolbasinyize0001@gmail.com',
          uri: Uri(
            scheme: 'mailto',
            path: 'auriolbasinyize0001@gmail.com',
            queryParameters: {'subject': 'Prise de contact'},
          ),
        ),
        const SizedBox(height: 12),
        const _ContactTile(
          icon: Icons.location_on_outlined,
          label: 'ADRESSE',
          value: 'À compléter',
        ),
        const SizedBox(height: 24),
        const _SectionTitle(title: 'Réseaux sociaux', eyebrow: 'EN LIGNE'),
        const SizedBox(height: 14),
        _ContactTile(
          icon: Icons.code_rounded,
          label: 'GITHUB',
          value: 'Découvrir GitHub',
          uri: Uri.parse('https://github.com'),
        ),
        const SizedBox(height: 12),
        _ContactTile(
          icon: Icons.work_outline_rounded,
          label: 'LINKEDIN',
          value: 'Découvrir LinkedIn',
          uri: Uri.parse('https://www.linkedin.com'),
        ),
        const SizedBox(height: 20),
        const Text(
          'Les profils personnels et l’adresse restent à ajouter.',
          textAlign: TextAlign.center,
          style: TextStyle(color: _muted, fontSize: 12),
        ),
      ],
    );
  }
}

class _ContactTile extends StatelessWidget {
  const _ContactTile({
    required this.icon,
    required this.label,
    required this.value,
    this.uri,
  });

  final IconData icon;
  final String label;
  final String value;
  final Uri? uri;

  @override
  Widget build(BuildContext context) {
    return _PaperCard(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          _IconTile(icon: icon),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: _muted,
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.3,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: _ink,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          if (uri != null)
            IconButton(
              tooltip: 'Ouvrir $label',
              onPressed: () async {
                if (!await launchUrl(uri!)) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Impossible d’ouvrir ce lien.'),
                      ),
                    );
                  }
                }
              },
              icon: const Icon(
                Icons.arrow_outward_rounded,
                color: _green,
                size: 20,
              ),
            ),
        ],
      ),
    );
  }
}

class _PaperCard extends StatelessWidget {
  const _PaperCard({
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEAF0EA)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A173B35),
            blurRadius: 16,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _IconTile extends StatelessWidget {
  const _IconTile({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: _mint,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Icon(icon, color: _green, size: 21),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0x33FFFFFF),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0x4DFFFFFF)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
