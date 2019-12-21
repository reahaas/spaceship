

# try:
#     # for Python2
#     from Tkinter import *   ## notice capitalized T in Tkinter
# except ImportError:
#     # for Python3
from tkinter import *   ## notice lowercase 't' in tkinter here
import tkinter as tk

from PIL import Image, ImageTk

# def super_function():
#     out = map(Entry.get, entr)
#     fen1.destroy()
#     print(out)
#
# fen1 = Tk()
# entr = []
# for i in range(10):
#     entr.append(Entry(fen1))
#     entr[i].grid(row=i+1)
#
#
#
# Button(fen1, text = 'store everything in a list', command = super_function).grid()


BOARD_SIZE = 12
BUTTON_SIZE = 5
E_SHIP_ICON = 1
B_SHIP_ICON = 2
STARS_ICON = 0
SHOT_ROCKET = 10

def get_zoomed_image_by_path(path):
    original_image = Image.open(path)
    zoomed = original_image.resize((50, 50))  # , Image.ANTIALIAS)

    photo = ImageTk.PhotoImage(zoomed)
    return photo


def build_images_dict():
    icons_dict = {}

    icons_dict[E_SHIP_ICON] = get_zoomed_image_by_path('Images/rocket-512.png')
    icons_dict[B_SHIP_ICON] = get_zoomed_image_by_path('Images/bugs_spaceship.jpeg')
    icons_dict[STARS_ICON] = get_zoomed_image_by_path('Images/stars.jpg')
    icons_dict[SHOT_ROCKET] = get_zoomed_image_by_path('Images/shot_rocket.jpeg')

    return icons_dict


def print_board(board):
    """

    :param board: list of list n*n size. each cell contain its value
    :return:
    """
    display = Tk()

    icons_dict = build_images_dict()

    button_list = []
    frame_list = []
    for i in range(BOARD_SIZE):
        frame_list.append(Frame(display))
        for j in range(BOARD_SIZE):

            button_text = board[i][j]

            button_background = icons_dict[button_text]

            temp_button = Button(frame_list[i], text=button_text, image=button_background)  # height=BUTTON_SIZE, width=BOARD_SIZE)  #
            button_list.append(temp_button)

            temp_button.pack(side=LEFT)

    for frame in frame_list:
        frame.pack(side=TOP)


    dashboard = Frame(display)
    e_hp = 1
    b_hp = 1
    current_turn = "bugs"
    ender_hp_lable = Label(dashboard, text="ender hp: {0}".format(e_hp)).pack()
    bugs_hp_lable = Label(dashboard, text="bugs hp: {0}".format(b_hp)).pack()
    turn_lable = Label(dashboard, text="turn: {0}".format(current_turn)).pack()
    dashboard.pack(side=BOTTOM)

    display.mainloop()


sample_board = [
    [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
]

# print_board(sample_board)


# for index name:
# button_text = str(i*BOARD_SIZE + j)

