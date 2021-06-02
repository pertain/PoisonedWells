poisonedWells
=============

A thematic twist on the classic Minesweeper game. In poisonedWells, individual cells
represent wells, and the objective is avoid wells which have been contaminated.

The game is still in development and is not yet fully functional. A game board
can be produced of varying sizes with an assortment of randomly placed poisoned
wells that scales with board size.

Currently working on a flood technique for clearing safe regions.


## Sample Board

Enter board size (integer): 10
┏━━━┳━━━┳━━━┳━━━┳━━━┳━━━┳━━━┳━━━┳━━━┳━━━┓
┃▐█▌┃▐█▌┃ ☠ ┃▐█▌┃▐█▌┃▐█▌┃▐█▌┃ ☠ ┃▐█▌┃ ☠ ┃
┣━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━┫
┃▐█▌┃▐█▌┃▐█▌┃▐█▌┃▐█▌┃▐█▌┃▐█▌┃▐█▌┃▐█▌┃▐█▌┃
┣━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━┫
┃▐█▌┃▐█▌┃▐█▌┃▐█▌┃▐█▌┃▐█▌┃ ☠ ┃▐█▌┃▐█▌┃▐█▌┃
┣━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━┫
┃▐█▌┃▐█▌┃▐█▌┃ ☠ ┃▐█▌┃ ☠ ┃▐█▌┃▐█▌┃▐█▌┃ ☠ ┃
┣━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━┫
┃▐█▌┃▐█▌┃▐█▌┃ ☠ ┃▐█▌┃▐█▌┃▐█▌┃▐█▌┃▐█▌┃▐█▌┃
┣━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━┫
┃▐█▌┃ ☠ ┃▐█▌┃▐█▌┃▐█▌┃▐█▌┃▐█▌┃ ☠ ┃▐█▌┃ ☠ ┃
┣━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━┫
┃▐█▌┃▐█▌┃▐█▌┃▐█▌┃▐█▌┃▐█▌┃▐█▌┃▐█▌┃▐█▌┃▐█▌┃
┣━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━┫
┃▐█▌┃▐█▌┃▐█▌┃ ☠ ┃▐█▌┃▐█▌┃▐█▌┃▐█▌┃▐█▌┃▐█▌┃
┣━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━┫
┃ ☠ ┃ ☠ ┃▐█▌┃▐█▌┃ ☠ ┃▐█▌┃ ☠ ┃ ☠ ┃▐█▌┃▐█▌┃
┣━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━╋━━━┫
┃ ☠ ┃▐█▌┃▐█▌┃ ☠ ┃ ☠ ┃▐█▌┃▐█▌┃▐█▌┃▐█▌┃▐█▌┃
┗━━━┻━━━┻━━━┻━━━┻━━━┻━━━┻━━━┻━━━┻━━━┻━━━┛

