module Yardstick
  module Method
    include Measurable

    measurement 'The method summary should be specified' do
      skip if has_tag?('see')
      summary != ''
    end

    measurement 'The method summary should be less than 80 characters in length' do
      summary.length <= 78
    end

    measurement 'The method summary should be a single line' do
      !summary.include?("\n")
    end

    measurement 'The method summary should not end in a period' do
      summary[0, -1] != '.'
    end

    measurement 'The public/semipublic method should have an example specified' do
      skip unless api?(%w[ public semipublic ]) && tag_types('return') != %w[ undefined ]
      has_tag?('example')
    end

    measurement 'The @api tag should be specified' do
      has_tag?('api')
    end

    measurement 'The @api tag must be either public, semipublic or private' do
      %w[ public semipublic private ].include?(tag_text('api'))
    end

    measurement 'A method with public visibility must have an @api tag of public, semipublic or private' do
      skip unless visibility == :public
      api?(%w[ public semipublic private ])
    end

    measurement 'A method with protected visibility must have an @api tag of semipublic or private' do
      skip unless visibility == :protected
      api?(%w[ semipublic private ])
    end

    measurement 'A method with private visibility must have an @api tag of private' do
      skip unless visibility == :private
      api?(%w[ private ])
    end

    measurement 'The @return tag should be specified' do
      has_tag?('return')
    end

  private

    # The text for a specified tag
    #
    # @param [String]
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
    # @param [String]
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
    # @param [Array<String>]
    #   a collection of API types
    #
    # @return [Boolean]
    #   true if the API type matches
    #
    # @api private
    def api?(types)
      types.include?(tag_text('api'))
    end
  end
end
