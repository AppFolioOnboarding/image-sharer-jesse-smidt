# frozen_string_literal: true

# == Schema Information
#
# Table name: images
#
#  id           :integer          not null, primary key
#  url          :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  lock_version :integer          not null
#

require 'uri'

class Image < ApplicationRecord
  validates :url,
            presence: true,
            length: {
              maximum: 255
            },
            format: {
              with: URI.regexp(%w[http https]),
              message: 'invalid format'
            }
end
