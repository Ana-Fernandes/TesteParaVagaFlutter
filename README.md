# MotelScreen - Tela de Exibição de Suítes

## 📌 Visão Geral
A `MotelScreen` é a tela responsável por exibir uma lista de suítes de um motel, permitindo que o usuário visualize as opções disponíveis e obtenha detalhes clicando na imagem da suíte. Quando uma suíte é selecionada, uma nova tela (
`DetalhesSuite`) é aberta, mostrando a imagem ampliada, o nome da suíte, o preço e um botão para reservar.

## 📲 Funcionalidades
- **Exibir uma lista de suítes** com imagem, nome e preço.
- **Interface elegante** com um fundo degradê vermelho e laranja.
- **Clique na imagem** para abrir uma tela de detalhes.
- **Tela de detalhes da suíte** exibe:
  - Imagem ampliada.
  - Nome da suíte.
  - Preço destacado em vermelho.
  - Botão "Reservar" verde vibrante.
  - Confirmação de reserva via `SnackBar`.

## 🎨 Design
### **MotelScreen** (Lista de Suítes)
- **Fundo degradê vermelho -> laranja**.
- **Cards de suítes estilizados** com sombra, bordas arredondadas e opacidade.
- **Nome da suíte em preto** para destaque.
- **Imagem clicável** para abrir a tela de detalhes.

## 🏗️ Responsabilidade da Tela
A `MotelScreen` tem a responsabilidade de exibir ao usuário uma lista de suítes do motel e permitir que ele visualize os detalhes e realize uma reserva. As funções principais incluem:

1. **Buscar as informações da API**.
2. **Exibir as suítes em um `ListView.builder`**.
3. **Permitir a interação clicando na imagem para abrir os detalhes**.
4. **Apresentar uma interface visual atraente** e responsiva.
5. **Exibir uma mensagem de sucesso ao reservar uma suíte**.

## 🛠️ Tecnologias Utilizadas
- **Flutter** (Dart)
- **Pacote `http`** para consumo da API.
- **Widgets como `Card`, `ListTile`, `GestureDetector` e `SnackBar`** para interatividade e UI.
- **`Navigator.push`** para navegação entre as telas.

## 📌 Exemplo de Uso
```dart
GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetalhesSuite(motel: motel),
      ),
    );
  },
  child: Image.network(motel.fotos[0]),
)
```

## 📸 Video/Capturas de Tela
| Lista de Suítes | Tela de Detalhes |

https://github.com/user-attachments/assets/fc6cd7da-d0d6-44ac-a8a5-2d8f41d37436


|-----------------|----------------|![Captura de tela 2025-02-15 145240](https://github.com/user-attachments/assets/256b7a6a-be94-428a-9012-3f245e6bb956)
![Captura de tela 2025-02-15 152207](https://github.com/user-attachments/assets/461be782-5438-4d7b-ad53-9346a82c20ae)
![Captura de tela 2025-02-15 152228](https://github.com/user-attachments/assets/fb0b7603-6d3f-40e3-a5ef-cae31b5657ed)
![Captura de tela 2025-02-15 152124](https://github.com/user-attachments/assets/9309dbd1-c02c-4b10-9352-d8546ad85570)



## 📢 Contribuição
Caso queira contribuir com melhorias, abra um `Pull Request` ou sugira alterações via `Issues` no GitHub.

## 📄 Licença
Este projeto está sob a licença MIT.

