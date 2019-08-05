module PageObjects
  class ImageNewPage < AePageObjects::Document
    path :new_image

    form_for :image do
      element :url
      element :tag_list
    end

    def create_image_invalid(path, tags = nil)
      url.set path
      tag_list.set tags

      node.click_on 'Create'
    end

    def create_image(path, tags = nil)
      url.set path
      tag_list.set tags

      node.click_on 'Create'
    end
  end
end
