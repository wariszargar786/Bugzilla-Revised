class Ability
  include CanCan::Ability
  def initialize(user)
    if user
      if user.Developer?
        can :index, DeveloperProjectsController
        can :show, DeveloperProjectsController
        can :solved, DeveloperProjectsController
        can :assign_himself, DeveloperProjectsController
        can :assign_himself_post, DeveloperProjectsController
      end
      if user.Manager?
        can :index, ProjectsController
        can :new, ProjectsController
        can :create, ProjectsController
        can :edit, ProjectsController
        can :show, ProjectsController
        can :update, ProjectsController
        can :add_user, ProjectsController
        can :add_user_post, ProjectsController
        can :destroy, ProjectsController
        can :delete_user_project, ProjectsController
      end
      if user.QA?
        can :index, QaProjectsController
        can :show, QaProjectsController
        can :new, BugsController
        can :create, BugsController
        can :edit, BugsController
        can :update, BugsController
        can :assign_developer, BugsController
        can :assign_developer_to_bug, BugsController
      end
    end
  end
end
