import itertools
from PIL import Image


def main():
    m_file = open('map.txt', 'r')
    m = []
    for line in m_file:
        m.append(map(int, line.strip().split(' ')))

    flatten_m = list(itertools.chain.from_iterable(m))

    m_max = max(flatten_m)
    m_min = min(flatten_m)
    m_range = m_max - m_min

    img = Image.new('RGB', (1000, 1000), "white")
    pixels = img.load()

    for i in range(img.size[0]):
        for j in range(img.size[1]):
            color = (m[i][j] - m_min) * 255 / m_range
            pixels[i, j] = (color, color, color)

    img.save("map.png")

main()