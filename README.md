# IFG Mobile Estudante 2.0 🚀

<p align="center">
  <img alt="Flutter" src="https://img.shields.io/badge/Flutter-2.10%2B-02569B?logo=flutter&logoColor=white">
  <img alt="Dart" src="https://img.shields.io/badge/Dart-2.16%2B-0175C2?logo=dart&logoColor=white">
  <img alt="Platform" src="https://img.shields.io/badge/Platform-Android%20%7C%20Windows-3DDC84">
  <img alt="Architecture" src="https://img.shields.io/badge/Architecture-Clean%20Architecture-6C63FF">
  <img alt="Status" src="https://img.shields.io/badge/Status-Em%20desenvolvimento-F39C12">
</p>

Aplicativo mobile desenvolvido em **Flutter** para estudantes do **Instituto Federal de Goiás (IFG)**, com integração ao **SUAP** para consulta de informações acadêmicas como **perfil do estudante**, **notas**, **materiais didáticos** e **horários de aula**.

Este projeto foi concebido com foco em **organização arquitetural**, **manutenibilidade** e **escalabilidade**, adotando princípios de **Clean Architecture** para separar responsabilidades e facilitar a evolução da aplicação.

---

## 📌 Visão geral

O **IFG Mobile Estudante 2.0** tem como objetivo centralizar, em uma interface acessível e moderna, informações acadêmicas relevantes para o estudante, reduzindo a fricção no acesso ao ecossistema institucional.

### Principais funcionalidades

- Autenticação do estudante
- Visualização de perfil acadêmico
- Consulta de notas
- Acesso a materiais didáticos
- Visualização de horários de aula
- Navegação por campi e páginas institucionais
- Integração com endpoints do SUAP

---

## 🖼️ Prévia da aplicação

<p align="center">
  <img src="https://github.com/user-attachments/assets/573f0e4c-7c17-4b59-97ff-e647fb030a18" alt="Tela de login" width="220" />
  <img src="https://github.com/user-attachments/assets/b3325c8d-e3b1-4e6e-8fc8-90a69dd6bc97" alt="Tela do estudante" width="220" />
  <img src="https://github.com/user-attachments/assets/a0eb29af-9142-42c4-8a72-03dfbe831653" alt="Tela acadêmica" width="220" />
</p>

> Sugestão para o repositório: caso deseje reforçar ainda mais a apresentação de portfólio, você pode substituir essas imagens por um GIF curto demonstrando a navegação principal do app.

---

## 🧱 Stack e tecnologias

- **Flutter**
- **Dart**
- **Provider** para gerenciamento de estado
- **GetIt** para injeção de dependências
- **Dio** para consumo de APIs
- **Secure Storage** para armazenamento seguro de dados sensíveis
- **Clean Architecture** para organização em camadas

---

## 🏗️ Arquitetura do projeto

A aplicação foi estruturada com base em **Clean Architecture**, separando o sistema em camadas independentes para reduzir acoplamento e facilitar testes, manutenção e expansão de funcionalidades.

### Benefícios da abordagem adotada

- **Separação clara de responsabilidades**
- **Facilidade de manutenção**
- **Maior testabilidade**
- **Escalabilidade para novas features**
- **Baixo acoplamento entre regras de negócio, dados e interface**

### Estrutura principal

```text
lib/
├── app/
├── core/
├── layers/
│   ├── data/
│   ├── domain/
│   └── presentation/
└── main.dart
```

### Resumo das camadas

#### `app/`
Responsável pela configuração e inicialização da aplicação, incluindo providers, setup de dependências e widget raiz.

#### `core/`
Contém utilitários, helpers e configurações compartilhadas entre diferentes módulos.

#### `layers/data/`
Camada responsável por fontes de dados, DTOs e implementações de repositórios.

#### `layers/domain/`
Contém entidades, contratos e casos de uso com as regras de negócio da aplicação.

#### `layers/presentation/`
Responsável pela interface, controllers, providers, estilos e telas exibidas ao usuário.

---

## 🚀 Como executar o projeto

### Pré-requisitos

Antes de iniciar, certifique-se de ter instalado:

- **Flutter SDK** `>= 2.10.0`
- **Dart SDK** `>= 2.16.0`
- **Git**
- **Visual Studio Code** ou **Android Studio**
- Para execução no Windows: **Visual Studio 2022** com a workload **Desktop development with C++**
- Um **emulador Android** configurado ou um **dispositivo físico**

---

### 1. Clonar o repositório

```bash
git clone https://github.com/Tarcyo/IFG-Mobile-2.0.git
cd IFG-Mobile-2.0
```

---

### 2. Configurar variáveis de ambiente

Crie um arquivo `.env` na raiz do projeto com a seguinte estrutura:

```dotenv
API_TOKEN=""
URL_Aluno=""
URL_Notas=""
```

> ⚠️ **Importante:** as credenciais e URLs utilizadas são sensíveis e não devem ser expostas publicamente.
>
> Para acesso aos dados necessários, entre em contato por e-mail: **tarcyomaia@gmail.com**

> ✅ Boa prática recomendada: manter também um arquivo `.env.example` no repositório para facilitar a configuração local sem expor dados reais.

---

### 3. Instalar dependências

```bash
flutter pub get
```

---

### 4. Executar no Android

#### Emulador

```bash
flutter emulators --launch <nome_do_emulador>
flutter run
```

#### Dispositivo físico

```bash
flutter devices
flutter run -d <ID_do_dispositivo>
```

---

### 5. Executar no Windows

```bash
flutter config --enable-windows-desktop
flutter pub get
flutter run -d windows
```

---

## 📂 Abertura no VS Code

```bash
code .
```

Extensões recomendadas:

- Flutter
- Dart

Para iniciar o modo de depuração, utilize `F5`.

---

## 📈 Status do projeto

| Funcionalidade | Status |
|---|---|
| Integração com SUAP | ✅ Concluído |
| Consulta de notas | ✅ Concluído |
| Perfil do estudante | ✅ Concluído |
| Material didático | 🚧 Em desenvolvimento |
| Boletim | 🚧 Em desenvolvimento |
| Horário de aulas | 🚧 Em desenvolvimento |

---

## 🛣️ Roadmap

Planejamentos e melhorias previstas para a evolução do projeto:

- Refinamento da experiência do usuário
- Ampliação dos módulos acadêmicos
- Evolução da cobertura de testes
- Melhorias na organização visual e usabilidade
- Possível publicação de versão demonstrativa

---

## 🤝 Contribuições

Contribuições são bem-vindas.

1. Faça um **fork** do repositório
2. Crie uma branch para sua feature:

```bash
git checkout -b feature/minha-feature
```

3. Faça o commit das alterações:

```bash
git commit -m "feat: adiciona minha feature"
```

4. Envie para o seu repositório remoto:

```bash
git push origin feature/minha-feature
```

5. Abra um **Pull Request**

---

## 📫 Contato

Para dúvidas, sugestões ou acesso às variáveis de ambiente do projeto:

- **Tarcyo Guilherme Maia Borges**
- **E-mail:** tarcyomaia@gmail.com
- **GitHub:** [Tarcyo](https://github.com/Tarcyo)

---

## 👨‍💻 Autor

Desenvolvido com dedicação por **Tarcyo Guilherme Maia Borges**.

<p align="center"><strong>Projeto desenvolvido para fins acadêmicos, práticos e de portfólio.</strong></p>
