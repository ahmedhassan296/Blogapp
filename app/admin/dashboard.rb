# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end


    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end

  end # content
  content do
    # Existing sections or dashboard content

    # Add a section with a link to view all Users
    section "Users" do
      div do
        link_to "View All Users", admin_users_path
      end
    end

    # Other sections or dashboard content...
  end
  content do
    # Existing sections or dashboard content

    # Add a section with a link to view all Users
    section "Posts" do
      div do
        link_to "View All Posts", admin_posts_path
      end
    end

    # Other sections or dashboard content...
  end

  content do
    # Existing sections or dashboard content

    # Add a section with a link to view all Users
    section "Likes" do
      div do
        link_to "View All Posts", admin_likes_path
      end
    end

    # Other sections or dashboard content...
  end

  
  
end
