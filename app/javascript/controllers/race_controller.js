// TODO: write your code here
const player1 = document.querySelectorAll('#player1-race td');
const player2 = document.querySelectorAll('#player2-race td');

let q = 0;
let p = 0;

const pressKey = (event) => {
  event.preventDefault();
  if (event.key === "q") {
    q += 1;
    player1[q].classList.add('active');
    player1[q - 1].classList.remove('active');
    if (player1[q].classList.contains('finish')) {
      player1[q].classList.add('winner1');
      player1[q].classList.remove('active');
      setTimeout(alert, 100, "Player 1 won!");
      window.setTimeout(window.location.reload.bind(window.location), 200);
      // document.setTimeout(document.location.reload(), 200);
    }
  } else if (event.key === "p") {
    p += 1;
    player2[p].classList.add('active');
    player2[p - 1].classList.remove('active');
    if (player2[p].classList.contains('finish')) {
      player2[p].classList.add('winner2');
      player2[p].classList.remove('active');
      setTimeout(alert, 100, "Player 2 won!");
      window.setTimeout(window.location.reload.bind(window.location), 200);
      // document.setTimeout(document.location.reload(), 200);
    }
  }
};

document.addEventListener('keyup', pressKey);
