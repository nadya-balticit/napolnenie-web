# -*- coding: utf-8 -*-
ActiveAdmin.register StaticPage do
  menu label: 'Страницы'

  filter :permalink

  form partial: "form"

  controller do
    defaults finder: :find_by_permalink

    # TODO: add bad response when photos can't destroy
    def destroy_slider_photo
      SliderPhoto.find(params[:id]).destroy
      head :ok
    end
  end

  form do |f|
    f.inputs do
      f.input :permalink
      f.input :text1, as: :html_editor
    end
    f.buttons
  end

  index do
    column :permalink
    column "Количество слайдов" do |page|
      page.slider_photos.count
    end
    default_actions
  end

  show do
    attributes_table :id, :permalink

    panel 'Текст' do
      simple_format resource.text1
    end

    active_admin_comments
  end

end
