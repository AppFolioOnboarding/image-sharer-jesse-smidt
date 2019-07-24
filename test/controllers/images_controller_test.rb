# frozen_string_literal: true

require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  test 'should get home with image with tags' do
    get root_url

    assert_response :success
    assert_select 'h1', text: 'Image Sharer'
    assert_select '.card img[src]'
    assert_select '.card .badge[href=?]', root_url(tag: 'fun'), text: 'fun'
    assert_select '.card form.edit_image input[value=delete]'
    assert_select '.card form.edit_image button[type=submit].card-delete-button'
  end

  test 'should show empty if no images' do
    Image.delete_all

    get root_url
    assert_response :success
    assert_select 'h3', text: 'No Images found for this tag'
    assert_select 'p a[href=?]', root_url
  end

  test 'should display new image form' do
    get new_image_path

    assert_response :success
    assert_select 'input#image_url'
  end

  test 'should create new image and respond with redirect' do
    post images_path,
         params: { image: { url: URL_PATH, tag_list: 'nice, fun' } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select 'a', URL_PATH
    assert_select 'a.badge:nth-of-type(1)[href=?]', root_url(tag: 'nice'), text: 'nice'
    assert_select 'a.badge:nth-of-type(2)[href=?]', root_url(tag: 'fun'), text: 'fun'
  end

  test 'should delete image' do
    image = Image.first
    assert_difference('Image.count', -1) do
      delete image_path(image)
    end

    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "img[src='#{image.url}']", false
  end

  URL_PATH = 'https://cdn.royalcanin-weshare-online.io/GvqPH2YBIYfdNSoCoAgj/v1/bd18bl-bernese-mountain-dog-adult-standing'
end
