$("#follow_form-<%= @user.id %>").html("<%= escape_javascript(render(partial: 'users/follow', locals: { user: @user})) %>");
$("#followers").html('<%= @user.followers.count %>');
