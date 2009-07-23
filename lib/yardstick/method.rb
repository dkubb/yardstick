module Yardstick
  module Method
    include Measurable

    rule 'The method summary should be specified' do
      skip if has_tag?('see')
      summary_text != ''
    end

    rule 'The method summary should be less than 80 characters in length' do
      summary_text.split(//).size <= 80
    end

    rule 'The method summary should not end in a period' do
      summary_text[-1, 1] != '.'
    end

    rule 'The method summary should be a single line' do
      !summary_text.include?("\n")
    end

    rule 'The public/semipublic method should have an example specified' do
      skip if api?(%w[ private ]) || tag_types('return') == %w[ undefined ]
      has_tag?('example')
    end

    rule 'The @api tag should be specified' do
      has_tag?('api')
    end

    rule 'The @api tag must be either public, semipublic or private' do
      %w[ public semipublic private ].include?(tag_text('api'))
    end

    rule 'A method with protected visibility must have an @api tag of semipublic or private' do
      skip unless visibility == :protected
      api?(%w[ semipublic private ])
    end

    rule 'A method with private visibility must have an @api tag of private' do
      skip unless visibility == :private
      api?(%w[ private ])
    end

    rule 'The @return tag should be specified' do
      has_tag?('return')
    end

  private

    # The raw text for the summary
    #
    # @return [String]
    #   the summary text
    #
    # @api private
    def summary_text
      split(/\r?\n\r?\n/).first || ''
    end

    # The text for a specified tag
    #
    # @param [String] tag_name
    #   the name of the tag
    #
    # @return [String, nil]
    #   the tag text if the tag exists
    #
    # @api private
    def tag_text(tag_name)
      tag(tag_name).text if has_tag?(tag_name)
    end

    # The types for a specified tag
    #
    # @param [String] tag_name
    #   the name of the tag
    #
    # @return [Array<String>, nil]
    #   a collection of tag types if the tag exists
    #
    # @api private
    def tag_types(tag_name)
      tag(tag_name).types if has_tag?(tag_name)
    end

    # The method visibility: public, protected or private
    #
    # @return [Symbol]
    #   the visibility of the method
    #
    # @api private
    def visibility
      object.visibility
    end

    # Check if the method API type matches
    #
    # @param [Array<String>] types
    #   a collection of API types
    #
    # @return [Boolean]
    #   true if the API type matches
    #
    # @api private
    def api?(types)
      types.include?(tag_text('api'))
    end

  end # module Method
end # module Yardstick
