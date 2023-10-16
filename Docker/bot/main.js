const mineflayer = require('mineflayer')
const { pathfinder, Movements, goals: { GoalNear } } = require('mineflayer-pathfinder')


const options = {
  host: 'localhost', // Change this to the ip you want.
  port: 25565 // Change this to the port you want.
}

const bot = mineflayer.createBot({
  host: 'localhost',
  port: 25565,
  username: 'SRE',
})

bot.loadPlugin(pathfinder)

bot.once('spawn', () => {
  bot.chat('Hello, I am SRE bot, I am keeping your server safe.');
  moveBot();
});

async function moveBot() {
  while(true) {
    await sleep(20000);
    navigateTo(86, 70, -57);
    await sleep(20000);
    navigateTo(102, 70, -58);
  }
}

function navigateTo(x, y, z) {
  const defaultMove = new Movements(bot)

  bot.pathfinder.setGoal(new GoalNear(x, y, z, 2))
}

function sleep(ms) {
  return new Promise((resolve) => {
    setTimeout(resolve, ms);
  });
}