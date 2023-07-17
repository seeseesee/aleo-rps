// The 'rps' program.
program rps.aleo {
    struct Round {
        finished: bool, // the round is finished or not
        players: u8,    // number of players/gesture in the round
        tie: bool,      // the round is tie or not
    }

    record Gesture {
        owner: address,     // owner of the record is the judge
        player: address,    // the player of the gesture
        hand: u8,           // 1 for Rock, 2 for Paper, 3 for Scissors.
        round: u32,         // round of the gesture
        win: bool,          // win or not
    }

    // public states for rounds
    mapping rounds: u32 => Round;

    // Returns a new gesture.
    // - `player` : The address of the account that extend hand and make the gesture.
    // - `round` : The round of the gesture.
    // - `hand` : The hand of the gesture, 1 for Rock, 2 for Paper, 3 for Scissors.
    // Requires that `hand` should be either of Rock, Paper, or Scissors.
    // One round for 2 players, save these public states in rounds.
    transition new_gesture(player: address, round: u32, hand: u8) -> Gesture {
        assert(hand >= 1u8);
        assert(hand <= 3u8);

        let gesture: Gesture = Gesture {
            owner: aleo1cyt22sj0gqcrm4xy8cum7tq9klsx9745laej870xnxzgtcez6qgse0mxvk,
            player: player,
            hand: hand,
            round: round,
            win: false,
        };

        return gesture then finalize(round);
    }
    finalize new_gesture(round: u32) {
        let round_exists: bool = Mapping::contains(rounds, round);
        if (round_exists) {
            let rd: Round = Mapping::get(rounds, round);
            assert_eq(rd.players, 1u8);
            let updated_rd: Round = Round {
                finished: rd.finished,
                players: rd.players + 1u8,
                tie: rd.tie,
            };
            Mapping::set(rounds, round, updated_rd);
        } else {
            let rd: Round = Round {
                finished: false,
                players: 1u8,
                tie: false,
            };
            Mapping::set(rounds, round, rd);
        }
    }

    // Returns gestures and marks the winner.
    // - `gesture0` : Player 1's gesture.
    // - `gesture1` : Player 2's gesture.
    // Make the round finished, and set tie flag if it's a tie.
    transition compare(gesture0: Gesture, gesture1: Gesture) -> (Gesture, Gesture) {
        // Only same round can be compared
        assert_eq(gesture0.round, gesture1.round);

        let result: u8 = 0u8;
        if (gesture0.hand == gesture1.hand) {
            // It's a tie!
        } else if ((gesture0.hand == 1u8 && gesture1.hand == 3u8) || (gesture0.hand == 2u8 && gesture1.hand == 1u8) || (gesture0.hand == 3u8 && gesture1.hand == 2u8)) {
            // gesture0 wins!
            result = 1u8;
        } else {
            // gesture1 wins!
            result = 2u8;
        }

        let ret_gesture0: Gesture = Gesture {
            owner: gesture0.owner,
            player: gesture0.player,
            hand: gesture0.hand,
            round: gesture0.round,
            win: result == 1u8,
        };

        let ret_gesture1: Gesture = Gesture {
            owner: gesture1.owner,
            player: gesture1.player,
            hand: gesture1.hand,
            round: gesture1.round,
            win: result == 2u8,
        };

        return (ret_gesture0, ret_gesture1) then finalize(gesture0.round, (result == 0u8));
    }
    finalize compare(round: u32, tie: bool) {
        let round_exists: bool = Mapping::contains(rounds, round);
        assert(round_exists);

        let rd: Round = Mapping::get(rounds, round);
        assert_eq(rd.players, 2u8);
        assert(!rd.finished);

        let updated_rd: Round = Round {
                finished: true,
                players: rd.players,
                tie: tie,
            };
        Mapping::set(rounds, round, updated_rd); 
    }
}
