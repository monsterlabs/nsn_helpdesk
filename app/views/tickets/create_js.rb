class Views::Tickets::CreateJs < Views::Layouts::ApplicationJs
  def js_content
    name_space = current_user.roles.first.name
    rawtext %Q(document.location.href = '/#{name_space}/tickets/';  )
  end
end
