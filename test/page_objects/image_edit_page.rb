module PageObjects
  class ImageEditPage < AePageObjects::Document
    path :edit_image

    form_for :image do
      element :image_tags
    end

    def update_tags!(new_tag_list)
      node.fill_in with: new_tag_list.join(', ')
      node.click_on 'Save'

      window.change_to(ImagesIndexPage)
    end
  end
end
