class Ability
  include CanCan::Ability
  def initialize(user)
    if user
      if user.Manager? or user.Developer? or user.QA?
        can :index, ProjectsController
        can :show, ProjectsController
      end
      if user.Developer? or user.QA?
        can :show_list_bugs, BugsController
      end
      if user.Developer?
        can :solved, DeveloperProjectsController
        can :assign_himself, DeveloperProjectsController
        can :assign_himself_post, DeveloperProjectsController
      end
      if user.Manager?
        can :new, ProjectsController
        can :show_list_user, ProjectsController
        can :create, ProjectsController
        can :edit, ProjectsController
        can :update, ProjectsController
        can :add_user, ProjectsController
        can :add_user_post, ProjectsController
        can :destroy, ProjectsController
        can :delete_user_project, ProjectsController
      end
      if user.QA?
        can :new, BugsController
        can :create, BugsController
        can :edit, BugsController
        can :update, BugsController
        can :assign_developer, BugsController
        can :assign_developer_to_bug, BugsController
        can :reassign_developer, BugsController
        can :reassign_developer_to_bug, BugsController
      end
    end
  end
end
