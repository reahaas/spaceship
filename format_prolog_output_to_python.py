# this file take prolog output (dictionary),
# and give nice way to work with the data in python.

BOARD_SIZE = 12

EMPTY_ICON = 0
ENDER_SHIP_ICON = 1
BUGS_SHIP_ICON = 2
SHOT_ICON = 10
ENDER_SHIP_HITED_ICON = ENDER_SHIP_ICON + SHOT_ICON
BUGS_SHIP_HITED_ICON = BUGS_SHIP_ICON + SHOT_ICON


def is_shot_in_location(x, y, shots):
    for shot in shots:
        location = shot[1]
        location_x = location[0]
        location_y = location[1]
        if x is location_x and y is location_y:
            return True
    return False  # no shot found in this location


def is_ship_in_location(x, y, ship):
    location = ship[1]
    location_x = location[0]
    location_y = location[1]
    if x is location_x and y is location_y:
        return True
    return False  # no shot found in this location


def get_icon(x, y, ender_ships, bugs_ships, shots):

    for ship in ender_ships:
        if is_ship_in_location(x, y, ship):
            if is_shot_in_location(x, y, shots):
                return ENDER_SHIP_HITED_ICON
            else:
                return ENDER_SHIP_ICON

    for ship in bugs_ships:
        if is_ship_in_location(x, y, ship):
            if is_shot_in_location(x, y, shots):
                return BUGS_SHIP_HITED_ICON
            else:
                return BUGS_SHIP_ICON

    if x > 1 and x <= BOARD_SIZE:
        if is_shot_in_location(x, y, shots):
            return SHOT_ICON

    return EMPTY_ICON


def print_board(ender_ships, bugs_ships, shots):
    board = [[0 for x in range(BOARD_SIZE)] for y in range(BOARD_SIZE)]
    # [][]  # [BOARD_SIZE][BOARD_SIZE]

    print("empty board: {}".format(board))
    # fill the borad with icons. run from 0 to BOARD_SIZE.
    for i in range(1, BOARD_SIZE+1):
        for j in range(1, BOARD_SIZE+1):
            # in prolog the rows are y, in python the rows are i
            board[i-1][j-1] = get_icon(j, i, ender_ships, bugs_ships, shots)

    return board

