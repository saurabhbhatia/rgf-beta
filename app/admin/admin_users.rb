ActiveAdmin.register AdminUser do
 controller.authorize_resource

 menu :if => proc{ can?(:manage, AdminUser) }   
ActiveAdmin.register AdminUser do    
  menu :if => proc{ can?(:manage, AdminUser) }     
  controller.authorize_resource 
end 
end
