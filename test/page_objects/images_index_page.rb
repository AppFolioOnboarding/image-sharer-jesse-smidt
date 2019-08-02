module PageObjects
  class ImagesIndexPage < AePageObjects::Document
    path :images
    path :root

    collection :images, locator: '#images_container', item_locator: '.card' do
      def image_src
        node.find('.display-image')[:src]
      end

      def delete!
        node.hover
        Capybara.current_session.accept_confirm do
          node.find('.fa-times').click
        end

        window.change_to(ImagesIndexPage)
      end
    end
  end
end
