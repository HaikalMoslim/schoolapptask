module SchoolsHelper
    def html_link_to(school)
        link_to school.address, school_path(school), target: '_blank', style: 'color: green'
    end
end