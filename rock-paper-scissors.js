
function getComputerChoice() {
    let choice = Math.floor(Math.random() * 3 + 1);

    switch(choice){
        case 1:
            return("rock")
        case 2:
            return("paper")
        case 3:
            return("scissors")
    };
};

function getPlayerChoice() {
    
    const VALID = ["rock", "paper", "scissors"];
    let choice = "";
    while(!VALID.includes(choice)){

        choice = prompt("Choose Rock, Paper or Scissors").toLowerCase();
    
        if (!VALID.includes(choice)){
            alert("Invalid choice, please choose Rock, Paper or Scissors");
        };
    };
    
    return(choice);

};

function playRound(playerSelection, computerSelection) {
    switch(playerSelection){
        case "rock":
            switch(computerSelection) {
                case "rock":
                    return "Draw!";
                case "paper":
                    return "Computer wins!";
                case "scissors":
                    return "Player wins!";
            };
        case "paper":
            switch(computerSelection) {
                case "rock":
                    return "Player wins!";
                case "paper":
                    return "Draw";
                case "scissors":
                    return "Computer Wins!";
            };
        case "scissors":
            switch(computerSelection) {
                case "rock":
                    return "Computer Wins!";
                case "paper":
                    return "Player Wins!";
                case "scissors":
                    return "Draw!";
            };
    };
  };
   

const playerSelection = getPlayerChoice();
// Todo create getPlayerChoice function with validation

const computerSelection = getComputerChoice();
alert(`Player chose ${playerSelection} and Computer chose ${computerSelection}, ${
    playRound(playerSelection, computerSelection)}`);