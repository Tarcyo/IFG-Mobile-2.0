# IFG Mobile Estudante 2.0 🚀


Um aplicativo móvel em Flutter para estudantes do IFG, totalmente integrado ao SUAP e com funcionalidades de visualização de perfil, notas, material didático e horário de aulas.

---

## 🔧 Pré-requisitos

- Flutter SDK (>=2.10.0)
- Dart SDK (>=2.16.0)
- Git
- Editor de código: **Visual Studio Code** ou **Android Studio** (para Windows: **Visual Studio** 2022 com workload de "Desktop development with C++").
- Dispositivo Android físico ou emulador configurado.

---

## 📥 Clonando o Repositório

```bash
# Clone o projeto
git clone https://github.com/Tarcyo/IFG-Mobile-2.0.git

# Acesse a pasta do projeto
cd IFG-Mobile-2.0
``` 

---

## 📂 Arquivo de Variáveis de Ambiente (.env)

Crie um arquivo `.env` na raiz do projeto com o seguinte conteúdo:

```dotenv
API_TOKEN=""
URL_Aluno=""
URL_Notas=""
```

> ⚠️ **Atenção:** Estes dados são sensíveis e não devem ser compartilhados publicamente.
> Para obtê-los, entre em contato com: **tarcyomaia@gmail.com**

---

## 💻 Executando no Android

### 1. Configurar o Android Studio

1. Baixe e instale o Android Studio: https://developer.android.com/studio
2. Abra o SDK Manager e instale o pacote mais recente do **Android SDK** e **Android SDK Platform-Tools**.
3. Configure um **Dispositivo Virtual Android (AVD)** no AVD Manager.

### 2. Executar no Emulador

```bash
# Instale as dependências
flutter pub get

# Para rodar em AVD (emulador)
flutter emulators --launch <nome_do_emulador>
flutter run
```

### 3. Alternativa: Executar em Dispositivo Android Físico

1. Ative a **Depuração USB** nas opções de desenvolvedor do seu dispositivo Android.
2. Conecte o dispositivo ao computador via USB.
3. Confirme a autorização de depuração no dispositivo.
4. No terminal, execute:
   ```bash
   flutter devices          # lista dispositivos disponíveis
   flutter run -d <ID_do_dispositivo>
   ```
5. Aguarde a instalação e inicialização do app no seu Android.

---

## 🪟 Executando no Windows (nativo)

1. Instale o Flutter SDK: https://docs.flutter.dev/get-started/install/windows
2. Instale o **Visual Studio 2022** com a carga de trabalho **Desktop development with C++**.
3. No PowerShell, habilite execução de scripts:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

4. Ative o suporte a desktop:

```bash
flutter config --enable-windows-desktop
flutter pub get
flutter run -d windows
```

---

## 🛠️ Abrindo no Visual Studio Code

1. Abra o VS Code na raiz do projeto:

   ```bash
   code .
   ```

2. Instale as extensões recomendadas (Flutter, Dart).
3. Use `F5` para iniciar o debug em qualquer plataforma.

---

## 🔖 Status do Projeto

| Funcionalidade          | Status       |
|-------------------------|--------------|
| Integração SUAP         | ✅ Integrado |
| Notas do Aluno          | ✅ Integrado |
| Material Didático       | 🚧 Mokado    |
| Boletim                 | 🚧 Mokado    |
| Horário de Aulas        | 🚧 Mokado    |

---


# 🏗️ Arquitetura do aplicativo

Este aplicativo oferece uma plataforma de gerenciamento escolar onde alunos podem visualizar suas notas, horários e boletins por meio da integração ao SUAP-Ensino, substituindo o aplicativo descontinuado integrado ao Q-Acadêmico. A estrutura modular e organizada garante performance, clareza e manutenibilidade, seguindo os princípios da Clean Architecture.

---

## 🔍 Visão Geral

Este aplicativo foi desenvolvido para fornecer aos estudantes uma forma simples e eficiente de acessar suas informações acadêmicas (notas, horários e boletins) por meio da API do SUAP-Ensino. A arquitetura limpa (Clean Architecture) foi adotada para assegurar:

- Alta coesão e baixo acoplamento
- Responsabilidades bem definidas
- Facilidade de testes e manutenção
- Escalabilidade para futuras funcionalidades

---

## 📂 Estrutura de Pastas

```
lib/
├── app/
├── core/
└── layers/
    ├── data/
    ├── domain/
    └── presentation/
└── main.dart
```

<a name="libapp"></a>
### 1. lib/app

Responsável pela configuração e bootstrap da aplicação.

| Arquivo                   | Descrição                                                     |
|---------------------------|---------------------------------------------------------------|
| `app_config_class.dart`   | Constantes de tema, fontes, tamanhos e URLs da API            |
| `app_providers.dart`      | Registro de providers e controllers para injeção de dependência |
| `app_setup.dart`          | Configuração do Service Locator (GetIt) e inicialização       |
| `app_widget.dart`         | Widget raiz com tema, rotas e responsividade                  |
| `auto_login_handler.dart` | Lógica de auto-login: valida token e redireciona usuário      |

<a name="libcore"></a>
### 2. lib/core

Infraestrutura e utilitários genéricos reutilizáveis.

```
lib/core/
├── inject/   (configuração de injeção de dependências)
└── utils/    (helpers: formatação, validação, network)
```

<a name="liblayers"></a>
### 3. lib/layers

Implementação da Clean Architecture, dividida em três camadas:

<a name="data"></a>
#### 3.1 Data

- **datasources/**: RemoteDatasource (DIO HTTP) e LocalDatasource (Hive / SharedPreferences)
- **dto/**: Data Transfer Objects para isolar o Domain dos detalhes da API
- **repositories/**: Implementação dos contratos, mapeamento de DTOs para entidades e tratamento de erros

<a name="domain"></a>
#### 3.2 Domain

- **entities/**: Modelos imutáveis (Aluno, Horário, Matéria, Nota)
- **repositories/**: Interfaces que definem contratos para acesso a dados
- **usecases/**: Casos de uso (GetBoletim, SaveNota) que encapsulam regras de negócio

<a name="presentation"></a>
#### 3.3 Presentation

- **controllers/**: ChangeNotifier ou Streams que acionam UseCases e gerenciam estado
- **providers/**: Configuração de Provider / Riverpod para disponibilizar controllers
- **screens/**: Widgets para cada tela do app
- **styles/**: Paleta de cores, tipografia, gradientes e CustomPainters

---

## 💡 Benefícios

- **Separação de Responsabilidades**: cada módulo tem uma única responsabilidade.
- **Testabilidade**: Domain e Data testáveis isoladamente.
- **Escalabilidade**: fácil inclusão de novos UseCases ou DataSources.
- **Manutenção**: alterações em API ou UI são localizadas.

---

## 🚀 Como Executar

```bash
# Instale dependências
flutter pub get

# Execute no emulador ou dispositivo conectado
flutter run
```

---

## 🤝 Contribuindo

1. Faça um fork do repositório
2. Crie uma branch para sua feature:
   ```bash
   git checkout -b feature/nova-funcionalidade
   ```
3. Commit suas alterações:
   ```bash
   git commit -m "Adiciona nova funcionalidade"
   ```
4. Envie para sua branch:
   ```bash
   git push origin feature/nova-funcionalidade
   ```
5. Abra um Pull Request neste repositório.

---

## 📄 Licença

Este projeto está licenciado sob a [MIT License](LICENSE).

---


## 📫 Contato

Para dúvidas sobre o `.env` ou acesso a credenciais, envie um e-mail para: **tarcyomaia@gmail.com**


<p align="center">Desenvolvido com ❤️ por Tarcyo Guilherme Maia Borges</p>

