
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

// function getPlayerChoice() {
    
//     const VALID = ["rock", "paper", "scissors"];
//     let choice = "";
//     while(!VALID.includes(choice)){

//         choice = prompt("Choose Rock, Paper or Scissors").toLowerCase();
    
//         if (!VALID.includes(choice)){
//             alert("Invalid choice, please choose Rock, Paper or Scissors");
//         };
//     };
    
//     return(choice);

// };

function playRound(playerSelection, computerSelection,) {
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
   


function game(playerSelection, score, round, results, buttons){

    let computerSelection = "";
  
        
    computerSelection = getComputerChoice();
    result = playRound(playerSelection, computerSelection);

    if (result == "Player wins!"){
        score[0]++
    } else if (result == "Computer wins!") {
        score[1]++
    }

    results.innerHTML = "<p>Round " + (round) + ": Player chose " + playerSelection + " and Computer chose " + computerSelection + " , " + result + "</p>" +
    "<p>Score is Player: " + score[0]+ " - Computer: " + score[1] + "</p>";

    if (round == 5) {
        if (score[0] > score[1]){
            results.textContent = `Player wins the game ${score[0]} to ${score[1]}!`;
        } else if (score[1] > score[0]){
            results.textContent = `Computer wins the game ${score[1]} to ${score[0]}!`;
        } else {
            results.textContent = "It's a draw!";
        }

        document.getElementById("intro").remove();
        buttons.forEach((button) => {
            button.remove()
        });

    }

    return score
};


const buttons = document.querySelectorAll('button');
let results = document.querySelector('#results');
results.setAttribute('style', 'white-space: pre;');

let score = [0 , 0], round = 0;

buttons.forEach((button) => {
    button.addEventListener('click', () => {
        round++;
        score = game(button.id, score, round, results, buttons);
    });
});