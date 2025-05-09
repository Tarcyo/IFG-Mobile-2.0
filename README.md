# IFG Mobile Estudante 2.0 🚀


Um aplicativo móvel em Flutter para estudantes do IFG, integrado ao SUAP e com funcionalidades de visualização de perfil, notas, material didático e horário de aulas.

---
⬇️ Instalação:

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

Este aplicativo foi desenvolvido para fornecer aos estudantes uma forma simples e eficiente de acessar suas informações acadêmicas (notas, horários, boletins e materiais) por meio da API do SUAP-Ensino. A arquitetura limpa (Clean Architecture) foi adotada para assegurar:

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
| `app_config_class.dart`   | Definição de constantes de controladores.
| `app_providers.dart`      | Registro de providers e controllers para injeção de dependência |
| `app_setup.dart`          | Configuração do  GetIt de injeção de dependências e inicialização       |
| `app_widget.dart`         | Widget raiz com definição tema e fontes de texto.                 |
| `auto_login_handler.dart` | Lógica de auto-login: resgata das criptografados do usuário via SecureStorage    |

<a name="libcore"></a>
### 2. lib/core

Infraestrutura e utilitários genéricos reutilizáveis.

```
lib/core/
├── inject/   (configuração de injeção de dependências)
└── utils/    (helpers e funções genéricas)
```

<a name="liblayers"></a>
### 3. lib/layers

Implementação da Clean Architecture, dividida em três camadas:

<a name="data"></a>
#### 3.1 Data

- **datasources/**: Implementações de requisições http via DIO
- **dto/**: Data Transfer Objects usados para transportar dados entre as camadas e lidar com as lógicas toJson e fromJson
- **repositories/**: Implementação dos contratos 

<a name="domain"></a>
#### 3.2 Domain

- **entities/**: Modelos das entidades
- **repositories/**: Interfaces que definem contratos para acesso a dados
- **usecases/**: Casos de uso que encapsulam regras de negócio

<a name="presentation"></a>
#### 3.3 Presentation

- **controllers/**: ChangeNotifier que acionam UseCases e gerenciam estado nas telas
- **providers/**: Configuração dos Provider para disponibilizar controllers
- **screens/**: Widgets para cada tela do app
- **styles/**: Estilos como paletas de cores

---

## 💡 Benefícios

- **Separação de Responsabilidades**: Cada módulo tem uma única responsabilidade.
- **Testabilidade**: Mais fácil testar os componentes.
- **Escalabilidade**: Fácil inclusão de novos UseCases ou DataSources.
- **Manutenção**: alterações em API ou UI são localizadas.

---
---

## 📱 Telas do aplicativo

### 1. Tela de login

Responsável pelo login do usuário ao entrar no sitema

Pasta:

![image](https://github.com/user-attachments/assets/680e492f-4862-447e-9d67-e34c423c9a8a)

Tela:

![image](https://github.com/user-attachments/assets/573f0e4c-7c17-4b59-97ff-e647fb030a18)

---

### 2. Tela da instituição

Responsável por disponibilizar links importantes para os sistemas da instituição.

Pasta:

![image](https://github.com/user-attachments/assets/0b37e4ad-85c1-4145-8ff8-600d4f2325ab)

Tela:

![image](https://github.com/user-attachments/assets/85ea3357-02ab-44e5-a5f5-aa979ad392a5)

---

### 3. Tela dos CAMPI:

Lista todos os Campi do Instituto.

Pasta:

![image](https://github.com/user-attachments/assets/3e651096-b302-43a9-8b38-71296353091b)

Tela:

![image](https://github.com/user-attachments/assets/27345784-1d2f-4c63-ade3-aa5bd7ff45cd)

---

### 4. Tela de dedicatória :

Tela de dedicatória ao orientador do projeto.

Pasta: 

![image](https://github.com/user-attachments/assets/4857760b-c6d0-4d11-a84e-bf71c7a33038)



Tela:

![image](https://github.com/user-attachments/assets/de4f28da-055d-46f0-b656-6c4dc673eaff)



---

### 5. Tela individual do campus :

Fornece informações e links para o campus individual

Pasta: 

![image](https://github.com/user-attachments/assets/afd7b25c-fb6d-4585-a9f6-da0ee5d8365d)


Tela:

![image](https://github.com/user-attachments/assets/a6245562-1fae-451b-be2d-0a1c79840711)

---

### 6. Tela do estudante :

Tela privada do estudante que requer login

Pasta: 

![image](https://github.com/user-attachments/assets/9c5bf274-bab9-4aa8-bd1d-dcd48d3d3b74)


Tela:

![image](https://github.com/user-attachments/assets/b3325c8d-e3b1-4e6e-8fc8-90a69dd6bc97)

---

### 7. Telas acadêmicas :

Mostram as informações acadêmicas dos estudantes resgatadas do SUAP-Ensino

Pastas: 

![image](https://github.com/user-attachments/assets/d23ed262-cbac-453a-8cf3-33da6c4a78c1)

![image](https://github.com/user-attachments/assets/b1b6cb07-1fc7-49ca-aaeb-6726014cda94)

![image](https://github.com/user-attachments/assets/a8ff571b-37dd-45b9-a5f5-48ac47df9959)

![image](https://github.com/user-attachments/assets/47429afc-65a9-4de9-bf08-99ac3d40aab4)

![image](https://github.com/user-attachments/assets/2acc0395-361a-466a-97f3-83bf597319fe)


Telas:

![image](https://github.com/user-attachments/assets/227d53b3-5ef1-4139-b5a2-8c878c18b533)

![image](https://github.com/user-attachments/assets/b237b233-6c59-42c1-992c-e1e4cbcf5319)

![image](https://github.com/user-attachments/assets/aa95f784-71bd-41c6-8e61-e68446a70fd1)

![image](https://github.com/user-attachments/assets/a0eb29af-9142-42c4-8a72-03dfbe831653)

![image](https://github.com/user-attachments/assets/0c83d681-fe65-4ffd-9885-94aceadeea6a)







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



## 📫 Contato

Para dúvidas sobre o `.env` ou acesso a credenciais, envie um e-mail para: **tarcyomaia@gmail.com**

---
<p align="center">Desenvolvido com ❤️ por Tarcyo Guilherme Maia Borges</p>

