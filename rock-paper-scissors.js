
function getComputerChoice() {
    let choice = Math.floor(Math.random() * 3 + 1);

    switch(choice){
        case 1:
            return("rock");
        case 2:
            return("paper");
        case 3:
            return("scissors");
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
                    return "Draw!";
                case "scissors":
                    return "Computer wins!";
            };
        case "scissors":
            switch(computerSelection) {
                case "rock":
                    return "Computer wins!";
                case "paper":
                    return "Player wins!";
                case "scissors":
                    return "Draw!";
            };
    };
  };
   


function game(){

    let playerSelection = "", computerSelection = "";
    let playerScore = 0, computerScore = 0;
    for (let i = 0; i < 5; i++){
        
        playerSelection = getPlayerChoice();
        computerSelection = getComputerChoice();
        result = playRound(playerSelection, computerSelection);

        if (result == "Player wins!"){
            playerScore++
        } else if (result == "Computer wins!") {
            computerScore++
        }

        alert(`Round ${i + 1}: Player chose ${playerSelection} and Computer chose ${computerSelection}, ${result}
    Score is Player: ${playerScore} - Computer: ${computerScore}`);

    };

    if (playerScore > computerScore){
        alert(`Player wins the game ${playerScore} to ${computerScore}!`);
    } else if (computerScore > playerScore){
        alert(`Computer wins the game ${computerScore} to ${playerScore}!`);
    } else {
        alert("It's a draw!");
    }
};

game();

// const playerSelection = getPlayerChoice();
// // Todo create getPlayerChoice function with validation

// const computerSelection = getComputerChoice();
// alert(`Player chose ${playerSelection} and Computer chose ${computerSelection}, ${
//     playRound(playerSelection, computerSelection)}`);