# GambitStudio - Configuração Claude

## REGRA PRINCIPAL
**Desenvolva o app COMPLETO. Não pare até terminar. Itere quantas vezes for necessário.**
- Não pergunte "quer que eu continue?" - CONTINUE
- Não pergunte "devo implementar X?" - IMPLEMENTE
- Se algo faz sentido para o app, adicione
- Só pare quando o app estiver pronto para publicar

---

## Dev
- João Flores | GambitStudio
- Dev experiente, publica apps há anos
- Comunicação: PT-BR
- Foco: produtividade máxima, menos conversa, mais código

---

## DESIGN SYSTEM (OBRIGATÓRIO)

### Estilo Visual
- **SEMPRE dark mode** como padrão
- Estética iOS-first (Cupertino quando apropriado)
- Clean, minimalista, premium
- Inspiração: apps Apple (Saúde, Fitness, Notes)

### Cores Padrão
```dart
// Dark Theme
background: Color(0xFF000000)        // Preto puro
surface: Color(0xFF1C1C1E)           // Cinza escuro iOS
surfaceVariant: Color(0xFF2C2C2E)    // Cards, containers
primary: Color(0xFF0A84FF)           // Azul iOS
secondary: Color(0xFF30D158)         // Verde iOS
accent: Color(0xFFFF9F0A)            // Laranja iOS
error: Color(0xFFFF453A)             // Vermelho iOS
text: Color(0xFFFFFFFF)              // Branco
textSecondary: Color(0xFF8E8E93)     // Cinza iOS
```

### Tipografia
- Fonte: SF Pro (system font do iOS) via `.systemFont`
- Títulos: bold, grandes
- Corpo: regular, boa legibilidade
- Hierarquia clara

### Animações (SEMPRE incluir)
- **Page transitions**: fade + slide sutil
- **Botões**: scale down ao pressionar (0.95)
- **Listas**: fade in sequencial nos items
- **Modals**: slide up com spring
- **Feedback**: haptic feedback em ações importantes
- Duração padrão: 200-300ms
- Curves: `Curves.easeOutCubic`

### Componentes
- Border radius: 12-16px (estilo iOS)
- Shadows sutis em cards
- Espaçamento generoso (16px mínimo)
- Safe areas sempre respeitadas
- Bottom sheet ao invés de alerts quando possível

---

## LOCALIZAÇÃO (OBRIGATÓRIO)

### Idiomas: PT-BR, EN-US, ES-ES (sempre os 3)

Estrutura:
```
lib/l10n/
├── app_pt.arb (português - padrão)
├── app_en.arb (inglês)
└── app_es.arb (espanhol)
```

- Usar `flutter_localizations` + `intl`
- Detectar idioma do sistema
- Permitir trocar manualmente em Settings
- NUNCA hardcode strings

---

## FEATURES OBRIGATÓRIAS (implementar sem pedir)

### 1. Onboarding Elegante
- 3-4 telas com ilustrações/ícones
- Animações entre páginas
- Indicador de página estilizado
- Botão "Pular" discreto
- Botão "Começar" destacado
- Persistir flag `onboarding_complete`

### 2. In-App Review Inteligente
- Package: `in_app_review`
- Trigger após momento positivo (3º uso, completar ação)
- Cooldown: 60 dias entre requests
- Tracking: `last_review_request`, `review_count`

### 3. Settings Completo
- Idioma (PT/EN/ES)
- Aparência (sempre dark, mas deixar opção)
- Notificações
- Avaliar app → abre store
- Compartilhar app
- Feedback/Suporte (email)
- Política de Privacidade
- Termos de Uso
- Versão do app
- Restaurar compras (se tiver IAP)

### 4. Share App
- Texto localizado
- Deep link quando possível
- Ícone de compartilhar no lugar certo

### 5. Estados de UI
- **Loading**: Shimmer/Skeleton elegante
- **Empty**: Ilustração + texto + CTA
- **Error**: Mensagem amigável + retry
- **Success**: Feedback visual + haptic

### 6. Navegação
- Bottom navigation (max 5 items)
- Ícones SF Symbols style
- Animação no item ativo
- Sem labels se possível (ícones claros)

### 7. Persistência
- SharedPreferences para configs
- SQLite ou Hive para dados complexos
- Backup/Export quando fizer sentido

### 8. Haptic Feedback
- Sucesso: `HapticFeedback.mediumImpact()`
- Erro: `HapticFeedback.heavyImpact()`
- Seleção: `HapticFeedback.selectionClick()`

---

## ESTRUTURA DE PROJETO

```
lib/
├── main.dart
├── app.dart                    # MaterialApp config
├── theme/
│   ├── app_theme.dart         # Dark theme
│   ├── colors.dart
│   └── text_styles.dart
├── l10n/                      # Traduções
├── models/
├── providers/                 # State management
├── screens/
│   ├── onboarding/
│   ├── home/
│   ├── settings/
│   └── [feature]/
├── widgets/
│   ├── common/               # Botões, cards, etc
│   └── [feature]/
├── services/
│   ├── storage_service.dart
│   ├── review_service.dart
│   └── [outros]/
└── utils/
    ├── constants.dart
    └── extensions.dart
```

---

## APP STORE

### Plataforma Principal: iOS
- Build ID: NZC6LC8NWM
- Testar em iPhone SE (menor) e iPad
- Bundle: com.gambitstudio.[appname]

### Metadata (gerar ao finalizar)
Para cada idioma (PT, EN, ES):
- Nome (30 chars)
- Subtítulo (30 chars)
- Descrição (4000 chars) - persuasiva, com emojis moderados
- Keywords (100 chars) - otimizadas ASO
- What's New
- Promotional Text

### Screenshots
- Gerar descrições para 6 screenshots
- Focar em benefícios, não features
- Frases curtas e impactantes

---

## CHECKLIST PRÉ-RELEASE

### Obrigatório
- [ ] Dark theme implementado
- [ ] 3 idiomas funcionando (PT/EN/ES)
- [ ] Onboarding completo
- [ ] In-app review configurado
- [ ] Settings com todas opções
- [ ] Empty states elegantes
- [ ] Loading states (shimmer)
- [ ] Error handling com retry
- [ ] Animações em transições
- [ ] Haptic feedback
- [ ] Testado iPhone SE
- [ ] Testado iPad
- [ ] Ícone 1024x1024
- [ ] Splash screen dark
- [ ] Build iOS sem warnings
- [ ] Metadata 3 idiomas

### Bônus
- [ ] Widget iOS (se aplicável)
- [ ] Shortcuts/Quick Actions
- [ ] Spotlight Search

---

## COMANDOS

| Digo | Você faz |
|------|----------|
| `crie [descrição]` | App completo do zero, não para até terminar |
| `continue` | Continua de onde parou |
| `status` | Mostra checklist do que falta |
| `metadata` | Gera textos App Store (3 idiomas) |
| `build` | Compila iOS, corrige erros |
| `polish` | Melhora animações e UI |
| `release` | Build final + metadata |

---

## PACKAGES PREFERIDOS

```yaml
# State
provider: ^6.1.2

# Storage
shared_preferences: ^2.2.2
hive: ^2.2.3  # para dados complexos

# UI
flutter_animate: ^4.5.0  # animações fáceis
shimmer: ^3.0.0          # loading states

# Utils
intl: any                # localização
in_app_review: ^2.0.9
share_plus: ^7.2.2
url_launcher: ^6.2.5
package_info_plus: ^5.0.1

# iOS específico
cupertino_icons: ^1.0.8
```

---

## EXEMPLO DE PROMPT IDEAL

```
Crie um app de [tema].

Features:
- [lista de funcionalidades]

Obs: [qualquer detalhe específico]
```

Só isso. O resto (design, animações, idiomas, onboarding, review, settings) eu faço automaticamente seguindo este documento.
