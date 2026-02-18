from pathlib import Path

SRC = Path('Assignments/Assi 1')
OUT = Path('Assignments/Assi 1.pdf')

PAGE_W, PAGE_H = 595, 842  # A4 points
MARGIN_X = 40
MARGIN_Y = 40
FONT_SIZE = 10
LINE_H = 12
MAX_CHARS = 92


def wrap_line(s: str, width: int):
    if not s:
        return ['']
    out = []
    while len(s) > width:
        out.append(s[:width])
        s = s[width:]
    out.append(s)
    return out


def pdf_escape(text: str) -> str:
    return text.replace('\\', '\\\\').replace('(', '\\(').replace(')', '\\)')


def build_pdf(lines):
    max_lines_per_page = int((PAGE_H - 2 * MARGIN_Y) // LINE_H)

    wrapped = []
    for line in lines:
        wrapped.extend(wrap_line(line.rstrip('\n'), MAX_CHARS))

    pages = [wrapped[i:i + max_lines_per_page] for i in range(0, len(wrapped), max_lines_per_page)]
    if not pages:
        pages = [['']]

    # Object numbers
    # 1: Catalog, 2: Pages, 3.. page/content pairs, last: Font
    objects = []

    font_obj_num = 3 + 2 * len(pages)

    # 1 Catalog
    objects.append((1, '<< /Type /Catalog /Pages 2 0 R >>'))

    # 2 Pages (kids filled after page refs known)
    kids_refs = []

    page_obj_start = 3
    for i, page_lines in enumerate(pages):
        page_obj = page_obj_start + i * 2
        content_obj = page_obj + 1
        kids_refs.append(f'{page_obj} 0 R')

        # Build content stream
        y_start = PAGE_H - MARGIN_Y - FONT_SIZE
        content_lines = ['BT', f'/F1 {FONT_SIZE} Tf']
        for idx, ln in enumerate(page_lines):
            y = y_start - idx * LINE_H
            content_lines.append(f'1 0 0 1 {MARGIN_X} {y} Tm ({pdf_escape(ln)}) Tj')
        content_lines.append('ET')
        stream = '\n'.join(content_lines)

        page_dict = (
            '<< /Type /Page /Parent 2 0 R '
            f'/MediaBox [0 0 {PAGE_W} {PAGE_H}] '
            f'/Resources << /Font << /F1 {font_obj_num} 0 R >> >> '
            f'/Contents {content_obj} 0 R >>'
        )
        objects.append((page_obj, page_dict))

        content_dict = f'<< /Length {len(stream.encode("latin-1", "replace"))} >>\nstream\n{stream}\nendstream'
        objects.append((content_obj, content_dict))

    pages_dict = f'<< /Type /Pages /Kids [{" ".join(kids_refs)}] /Count {len(pages)} >>'
    objects.insert(1, (2, pages_dict))

    # Font object
    objects.append((font_obj_num, '<< /Type /Font /Subtype /Type1 /BaseFont /Helvetica >>'))

    # Serialize with xref
    objects.sort(key=lambda x: x[0])
    out = bytearray()
    out.extend(b'%PDF-1.4\n')

    offsets = [0] * (objects[-1][0] + 1)
    for obj_num, content in objects:
        offsets[obj_num] = len(out)
        out.extend(f'{obj_num} 0 obj\n'.encode('latin-1'))
        out.extend(content.encode('latin-1', 'replace'))
        out.extend(b'\nendobj\n')

    xref_start = len(out)
    out.extend(f'xref\n0 {len(offsets)}\n'.encode('latin-1'))
    out.extend(b'0000000000 65535 f \n')
    for i in range(1, len(offsets)):
        out.extend(f'{offsets[i]:010d} 00000 n \n'.encode('latin-1'))

    out.extend(b'trailer\n')
    out.extend(f'<< /Size {len(offsets)} /Root 1 0 R >>\n'.encode('latin-1'))
    out.extend(b'startxref\n')
    out.extend(f'{xref_start}\n'.encode('latin-1'))
    out.extend(b'%%EOF\n')
    return bytes(out)


def main():
    lines = SRC.read_text(encoding='utf-8').splitlines()
    pdf_bytes = build_pdf(lines)
    OUT.write_bytes(pdf_bytes)
    print(f'Created: {OUT}')


if __name__ == '__main__':
    main()
