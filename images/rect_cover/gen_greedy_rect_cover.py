import heapq
import math
import os
from PIL import Image, ImageDraw, ImageFont
import PIL
import numpy as np

IMG_SZ = 400
regular = (0,0,0,int(255*0.2))
selected = (0,0,0,int(255))
TILE_SIZE = 200


def contains(outer, inner):
    ldiff = inner[0] - outer[0]
    tdiff = inner[1] - outer[1]
    rdiff = outer[2] - inner[2]
    bdiff = outer[3] - inner[3]
    return (ldiff >= 0) & (tdiff >= 0) & (rdiff >= 0) & (bdiff >= 0)


def generate_data(num_boxes, region_size, max_box_size):
    assert max_box_size > 0 and num_boxes > 0 and region_size > 0
    assert region_size > max_box_size, "Region size must be larger than the max box size"
    box_positions = np.random.randint(low=0, high=region_size-max_box_size, size=(num_boxes, 2), dtype="int32")
    box_sizes = np.random.randint(low=6, high=max_box_size, size=(num_boxes, 2), dtype="int32")
    boxes = np.concatenate([box_positions, box_positions+box_sizes], axis=1)
    return boxes


def generate_data_norm(num_boxes, region_size, max_box_size):
    assert max_box_size > 0 and num_boxes > 0 and region_size > 0
    assert region_size > max_box_size, "Region size must be larger than the max box size"
    box_positions = np.random.normal(loc=region_size/2, scale=region_size/6, size=(num_boxes, 2)).astype(dtype="int32")
    box_positions = np.maximum(0, np.minimum(box_positions, region_size))
    box_sizes = np.random.randint(low=6, high=max_box_size, size=(num_boxes, 2), dtype="int32")
    boxes = np.concatenate([box_positions, box_positions+box_sizes], axis=1)
    return boxes


def draw_cbox(imgdraw, box, color=selected, width=1, rotate=0):
    x1, y1, x2, y2 = box
    if rotate:
        x1, y1, x2, y2 = y1, x1, y2, x2
    imgdraw.rectangle(((x1, y1), (x2, y2)), outline=color, fill=None, width=width)


def generate_rect_cover(boxes):
    # fnt = ImageFont.FreeTypeFont(size=20)
    fnt = ImageFont.truetype(os.path.join(os.path.dirname(__file__),"07558_CenturyGothic.ttf"), 35)
    # draw text, half opacity
    base = Image.new('RGBA', (IMG_SZ, IMG_SZ), (255,255,255,255))
    draw = ImageDraw.Draw(base)
    draw.text((10, 10), "Generating Optimal Tiles", font=fnt, fill=(0, 0, 0, 255))
    for b in boxes:
        draw_cbox(draw, b, color='black',width=1,rotate=0)
    for i in range(10):
        yield base
    
    tiles = []

    for i1, b1 in enumerate(boxes):
        for i2, b2 in enumerate(boxes):
            b1x1, b1y1, b1x2, b1y2 = b1
            b2x1, b2y1, b2x2, b2y2 = b2
            # choosing tile where b1 is the object bounding on right, and b2 is on top
            if b2y1 <= b1y1 and b1x1 <= b2x1:
                tile = np.array([b1x1, b2y1, b1x1+TILE_SIZE, b2y1+TILE_SIZE],dtype="int32")
                if contains(tile, b1) & contains(tile, b2):
                    tiles.append(tile)
                    draw_cbox(draw, tile, color='blue',width=1,rotate=0)
                    yield base
    
    for i in range(5):
        yield base
    
    tile_heap = [(-contains(tile, boxes.T).sum(), idx, tile) for idx,tile in enumerate(tiles)]
    heapq.heapify(tile_heap)

    taken_boxes = np.zeros((0,4), dtype="int32")
    taken_tiles = []
    while tile_heap:
        n_score, tidx, best_tile = heapq.heappop(tile_heap)
        score = -n_score

        base = Image.new('RGBA', (IMG_SZ, IMG_SZ), (255,255,255,255))
        draw = ImageDraw.Draw(base)
        draw.text((10, 10), "Greedy selection w/priority queue", font=fnt, fill=(0, 0, 0, 255))
        # for b in taken_boxes:
        #     draw_cbox(draw, b, color='green',width=1,rotate=0)

        # for b,s in taken_tiles:
        #     draw_cbox(draw, b, color='green',width=1,rotate=0)

        for s, i, t in reversed(tile_heap):
            draw_cbox(draw, t, color=(200,200,200),width=int(math.sqrt(-s*3)),rotate=0)
        for b in boxes:
            draw_cbox(draw, b, color='black',width=1,rotate=0)
        
        new_mask = contains(best_tile, boxes.T)
        new_boxes = boxes[new_mask]
        new_score = len(new_boxes)

        for b in new_boxes:
            draw_cbox(draw, b, color='yellow',width=1,rotate=0)
        draw_cbox(draw, best_tile, color='yellow',width=int(math.sqrt(score*3)),rotate=0)
        yield base

        if new_score == score:
            draw_cbox(draw, best_tile, color='green',width=int(math.sqrt(score*3)),rotate=0)
            for b in new_boxes:
                draw_cbox(draw, best_tile, color='green',width=1,rotate=0)
            yield base
            taken_boxes = np.concatenate([taken_boxes, new_boxes], axis=0)
            taken_tiles.append((best_tile, new_score))
            boxes = boxes[~new_mask]
        elif new_score == 0:
            draw_cbox(draw, best_tile, color='red',width=int(math.sqrt(score*3)),rotate=0)
            yield base
        else:
            draw_cbox(draw, best_tile, color='blue',width=int(math.sqrt(new_score*3)),rotate=0)
            yield base
            heapq.heappush(tile_heap, (-new_score, tidx, best_tile))
    
    base = Image.new('RGBA', (IMG_SZ, IMG_SZ), (255,255,255,255))
    draw = ImageDraw.Draw(base)
    draw.text((10, 10), "Final Selection", font=fnt, fill=(0, 0, 0, 255))
    for b in taken_boxes:
        draw_cbox(draw, b, color='black',width=1,rotate=0)

    for b,s in taken_tiles:
        b[0] -= 1
        draw_cbox(draw, b, color='green',width=1,rotate=0)

    for i in range(50):
        yield base


def dup_images_for_slowness(img_gen):
    for img in img_gen:
        for i in range(10):
            yield img

def save_line_search_gif(fname, boxes):
    img_generator = dup_images_for_slowness(generate_rect_cover(boxes))
    img1 = next(img_generator)

    img1.save(f'docs/{fname}',
                save_all=True, append_images=img_generator, optimize=True, duration=6, loop=0)


IMG_SZ = 600
TILE_SIZE = 200
save_line_search_gif("rect_cover_norm.gif", generate_data_norm(20, IMG_SZ, IMG_SZ//12))


IMG_SZ = 600
TILE_SIZE = 100
save_line_search_gif("rect_cover_small.gif", generate_data_norm(50, IMG_SZ, IMG_SZ//20))
