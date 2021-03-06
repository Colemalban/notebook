class UniverseCoreContentAuthorizer < CoreContentAuthorizer
  def self.creatable_by? user
    [
      PermissionService.user_has_fewer_owned_universes_than_plan_limit?(user: user),
    ].any?
  end

  def readable_by? user
    [
      PermissionService.content_is_public?(content: resource),
      PermissionService.user_owns_content?(user: user, content: resource),
      PermissionService.user_can_contribute_to_universe?(user: user, universe: resource)
    ].any?
  end

  def updatable_by? user
    [
      PermissionService.user_owns_content?(user: user, content: resource),
      PermissionService.user_can_contribute_to_universe?(user: user, universe: resource)
    ].any?
  end

  def deletable_by? user
    [
      PermissionService.user_owns_content?(user: user, content: resource)
    ].any?
  end
end
