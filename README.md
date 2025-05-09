# IFG Mobile Estudante 2.0 🚀

[![SUAP Integrado](https://img.shields.io/badge/SUAP-Integrado-brightgreen)](https://suap.ifg.edu.br)
[![Material Mokado](https://img.shields.io/badge/Material-Mokado-yellow)](#)
[![Boletim](https://img.shields.io/badge/Boletim-Mokado-blue)](#)
[![Horário de Aula](https://img.shields.io/badge/Hor%C3%A1rio-Hor%C3%A1rio%20Mokado-orange)](#)

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

### 3. Executar em Dispositivo Android Físico

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

## 🤝 Contribuição

1. Fork este repositório
2. Crie uma branch: `git checkout -b feature/minha-nova-funcionalidade`
3. Faça seu commit: `git commit -m 'Adiciona nova funcionalidade'`
4. Envie para o branch: `git push origin feature/minha-nova-funcionalidade`
5. Abra um Pull Request

---

## 📫 Contato

Para dúvidas sobre o `.env` ou acesso a credenciais, envie um e-mail para: **tarcyomaia@gmail.com**

---

<p align="center">Desenvolvido com ❤️ por Tarcyo Maia</p>
