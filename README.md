# Rock Paper Scissors

Rock-paper-scissors is a simple hand gesture game played between two players. Each player simultaneously makes a hand gesture representing either rock, paper, or scissors. The outcome of the game is determined by the following rules:

1. Rock beats scissors.
2. Scissors beat paper.
3. Paper beats rock.

The gameplay follows these steps:

Both players extend their hands and choose one gesture: rock, paper, or scissors.
Based on the rules mentioned above, compare the gestures of the two players to determine the outcome.
Determine the winner based on the outcome. If both players choose the same gesture, the game is a tie.

In our Rock-paper-scissors game, players will be able to engage in multiple rounds where only two gestures (from two players) are compared in each round. In our DAPP, the number 1 represents "Rock," the number 2 represents "Paper," and the number 3 represents "Scissors." After each round of comparison, the gestures used in that round are not allowed to be used again, and new gestures are generated for the next round of play.

*The owner of the gesture record is set to the judge responsible for running the compare. So two records don't have any Input record signer problems.*

## How to build

To compile this Aleo program, run:
```bash
leo build
```

## How to run
### 1. Initializing the Players and the Judge
In order to play Rock-paper-scissors, there must be two players. Players will be represented by their Aleo address. You can use the provided player accounts or generate your own.
```
Judge:
    Private Key  APrivateKey1zkp7nzfqG2AkHu7dyh82cSE5NvLDuJswLfFFyoY5DhF78Q8
    Address  aleo1cyt22sj0gqcrm4xy8cum7tq9klsx9745laej870xnxzgtcez6qgse0mxvk

Player 1:
    Private Key  APrivateKey1zkp9ijo8mVDMaX9zTmdGcN5kGzDDS5w5vTL3RhjYYQ1hE6y
    Address  aleo10l5gua633p9tzw5f87a9m7snfq6cpx0p9qccd8g64zjjld52lu9scmpwdm

Player 2:
    Private Key  APrivateKey1zkp86FNGdKxjgAdgQZ967bqBanjuHkAaoRe19RK24ZCGsHH
    Address  aleo1wyvu96dvv0auq9e4qme54kjuhzglyfcf576h0g3nrrmrmr0505pqd6wnry
```

Save the keys and addresses. Set the program.json private key and address to the judge.
```json
{
    "program": "rps.aleo",
    "version": "0.0.0",
    "description": "",
    "development": {
        "private_key": "APrivateKey1zkp7nzfqG2AkHu7dyh82cSE5NvLDuJswLfFFyoY5DhF78Q8",
        "address": "aleo1cyt22sj0gqcrm4xy8cum7tq9klsx9745laej870xnxzgtcez6qgse0mxvk"
    },
    "license": "MIT"
}

```

### 2. Player 1 Generate new gesture
Now, we need to extend hand and make a gesture for Player 1. For this example, Player 1 choose Rock in round 1.

**Run**
```
leo run new_gesture aleo10l5gua633p9tzw5f87a9m7snfq6cpx0p9qccd8g64zjjld52lu9scmpwdm 1u32 1u8
```

**Output**
```bash
➡️  Output

 • {
  owner: aleo1cyt22sj0gqcrm4xy8cum7tq9klsx9745laej870xnxzgtcez6qgse0mxvk.private,
  player: aleo10l5gua633p9tzw5f87a9m7snfq6cpx0p9qccd8g64zjjld52lu9scmpwdm.private,
  hand: 1u8.private,
  round: 1u32.private,
  win: false.private,
  _nonce: 3558551399071249752215665616720482274755213031909624101646237595297701767466group.public
}
```

### 3. Player 2 Generate new gesture
Now, we need to extend hand and make a gesture for Player 2. For this example, Player 2 choose Paper in round 1.

**Run**
```bash
leo run new_gesture aleo1wyvu96dvv0auq9e4qme54kjuhzglyfcf576h0g3nrrmrmr0505pqd6wnry 1u32 2u8
```

**Output**
```bash
➡️  Output

 • {
  owner: aleo1cyt22sj0gqcrm4xy8cum7tq9klsx9745laej870xnxzgtcez6qgse0mxvk.private,
  player: aleo1wyvu96dvv0auq9e4qme54kjuhzglyfcf576h0g3nrrmrmr0505pqd6wnry.private,
  hand: 2u8.private,
  round: 1u32.private,
  win: false.private,
  _nonce: 3007551504520915330450799815382396716899658108654469146645306589284614209378group.public
}
```

### 4. Compare the gestures
Now, the judge uses two gestures to compare which one wins or it's a tie.

**Run**
```bash
leo run compare "{
  owner: aleo1cyt22sj0gqcrm4xy8cum7tq9klsx9745laej870xnxzgtcez6qgse0mxvk.private,
  player: aleo10l5gua633p9tzw5f87a9m7snfq6cpx0p9qccd8g64zjjld52lu9scmpwdm.private,
  hand: 1u8.private,
  round: 1u32.private,
  win: false.private,
  _nonce: 3558551399071249752215665616720482274755213031909624101646237595297701767466group.public
}" "{
  owner: aleo1cyt22sj0gqcrm4xy8cum7tq9klsx9745laej870xnxzgtcez6qgse0mxvk.private,
  player: aleo1wyvu96dvv0auq9e4qme54kjuhzglyfcf576h0g3nrrmrmr0505pqd6wnry.private,
  hand: 2u8.private,
  round: 1u32.private,
  win: false.private,
  _nonce: 3007551504520915330450799815382396716899658108654469146645306589284614209378group.public
}"
```

And the output tells the Player 2 wins!

**Output**
```bash
➡️  Outputs

 • {
  owner: aleo1cyt22sj0gqcrm4xy8cum7tq9klsx9745laej870xnxzgtcez6qgse0mxvk.private,
  player: aleo10l5gua633p9tzw5f87a9m7snfq6cpx0p9qccd8g64zjjld52lu9scmpwdm.private,
  hand: 1u8.private,
  round: 1u32.private,
  win: false.private,
  _nonce: 8036992901032368516570494993191631332187706584305215032765814982172707938912group.public
}
 • {
  owner: aleo1cyt22sj0gqcrm4xy8cum7tq9klsx9745laej870xnxzgtcez6qgse0mxvk.private,
  player: aleo1wyvu96dvv0auq9e4qme54kjuhzglyfcf576h0g3nrrmrmr0505pqd6wnry.private,
  hand: 2u8.private,
  round: 1u32.private,
  win: true.private,
  _nonce: 2936112025224800552293513848531426714567669119853361719870692079456778053568group.public
}
```