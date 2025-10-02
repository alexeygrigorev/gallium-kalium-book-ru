# Makefile for building the Gallium-Kalium book

CHAPTERS_DIR = chapters
OUTPUT_DIR = output
CHAPTERS = $(sort $(wildcard $(CHAPTERS_DIR)/*.md))

# Output files
EPUB_FILE = $(OUTPUT_DIR)/gallium-kalium-book.epub
MOBI_FILE = $(OUTPUT_DIR)/gallium-kalium-book.mobi

.PHONY: all clean epub mobi

all: epub mobi

$(OUTPUT_DIR):
	mkdir -p $(OUTPUT_DIR)

epub: $(EPUB_FILE)

$(EPUB_FILE): $(CHAPTERS) metadata.yaml | $(OUTPUT_DIR)
	pandoc metadata.yaml $(CHAPTERS) -o $(EPUB_FILE) \
		--toc --toc-depth=2 \
		--metadata title="Калий, галлий и их сплав: Химические приключения"

mobi: $(MOBI_FILE)

$(MOBI_FILE): $(EPUB_FILE)
	ebook-convert $(EPUB_FILE) $(MOBI_FILE)

clean:
	rm -rf $(OUTPUT_DIR)
