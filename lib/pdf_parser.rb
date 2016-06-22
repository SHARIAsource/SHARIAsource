require 'RMagick'
require 'grim'
require 'whatlanguage'
require 'similar_text'


module PdfParser

  def build_text_by_hybrid page_text, img_path
    page_map = RTesseract::Box.new(img_path, lang: 'en')
    return parse_text(page_text, page_map, img_path)
  end

  def parse_text(page_text, page_map, img_path)
    page_text = page_text.force_encoding('UTF-8')
    blocks = block_text_by_non_latin(page_text)
    build_page(blocks, page_map, img_path) unless blocks.nil?
  end

  def build_page(blocks, page_map, img_path)
    result = []
    # use inject to iterate by adjacent pairs
    blocks.inject do |top_block, bottom_block|
      result << top_block
      arabic_start = block_bottom_bound(top_block, page_map)
      arabic_end = block_top_bound(bottom_block, page_map)
      unless arabic_start.nil? || arabic_end.nil?
        arabic = ocr_arabic_block(arabic_start[:word][:y_end],
                                  arabic_end[:word][:y_start],
                                  img_path)
        result << arabic
      end
      # accumulate bottom block
      bottom_block
    end
    result << blocks.last
    result.join(' ')
  end

  # split the page text around non-latin blocks
  def block_text_by_non_latin(page_text)
    chars = page_text.split('')
    # aggregate all of the latin text
    result = chars.reduce([[]]) do |total, c|
      if c.is_non_latin?
        total.push [] unless total.last.empty?
      elsif total.last.empty? && !c.is_whitespace?
        # just out of non-latin
        total.last.push c
      elsif !total.last.empty?
        # in latin
        total.last.push c
      end
      total
    end
    result.map! &:join
    result.reject! { |block| !block.strip.is_word? || block.nil? } # filtering
    return result

  end

  # get the last word of the block
  def block_bottom_bound(block, page_map)
    block = block.split(' ')
    matches = page_map.words.each_with_index.select do |word, _idx|
      word[:word].downcase.include?(find_first_word(block.reverse).downcase)
    end.map &:last

    # contextually locate the top word
    matches.map! do |match|
      ocr_string = []
      for i in (match / 2..match)
        ocr_string << page_map.words[i][:word]
      end
      ocr_string = ocr_string.join(' ')
      parsed_string = block[0..block.length].join(' ')
      similarity = ocr_string.similar(parsed_string)
      match = { similarity: similarity, word: page_map.words[match] }
    end.sort_by! { |e| e[:similarity] }

    result = matches.last # the best result
    result[:block] = block.join(' ') unless result.nil?
    result
  end

  # get the first word of a block
  def block_top_bound(block, page_map)
    block = block.split(' ')
    # get the possible word locations
    matches = page_map.words.each_with_index.select do |word, _idx|
      word[:word].downcase.include?(find_first_word(block).downcase)
    end.map &:last

    # contextually locate the top word
    matches.map! do |match|
      ocr_string = []
      page_map.words[match..match * 2].each { |word| ocr_string << word[:word] }
      ocr_string = ocr_string.join(' ')
      parsed_string = block[0..block.length].join(' ')
      similarity = ocr_string.similar(parsed_string)
      match = { similarity: similarity, word: page_map.words[match] }
    end.sort_by! { |e| e[:similarity] }

    result = matches.last # the best result
    result[:block] = block.join(' ') unless result.nil?
    result
  end

  # sometimes the last space-delimited substring is bad, like
  # punctuation, etc
  def find_first_word(text_array)
    text_array.each do |s|
      return s if s.is_word? && s.is_a?(String)
    end
    # if we can't find it, just return
    # the original word and hope for the best
    text_array.first
  end

  # determine arabic script within a spatial bound
  def ocr_arabic_block(y_start, y_end, img_path)
    img = Magick::Image.ping(img_path).first
    block_width = img.columns # document width (pxl)
    block_height = (y_end - y_start).abs
    block = RTesseract::Mixed.new(img_path, lang: 'ara', areas: [
                                    { x: 0, y: y_start, w: block_width, h: block_height }
                                  ])
    block.to_s
  end
end

class String
  def is_non_latin?
    !ascii_only? &&
      !(/[[:punct:]]/u =~ self) &&
      !(/\p{S}/u =~ self) &&
      !(ord == 226)
  rescue Encoding::CompatibilityError
    # rather have false negatives
    return false
  end

  def contains_latin?
    !!(/[a-zA-Z]/u =~ self)
  end

  def is_whitespace?
    !!(/^\s*$/u =~ self)
  rescue Encoding::CompatibilityError
    return false
  end

  def is_word?
    # contain some latin characters
    # not containing crap is implied
    # remove all whitespace
    split(' ').join('').contains_latin?
  end
end
