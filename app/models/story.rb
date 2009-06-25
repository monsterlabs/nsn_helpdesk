class Story < ActiveResource::Base
   self.site = "http://www.pivotaltracker.com/services/v2/projects/19379"
   headers['X-TrackerToken'] = '8bf6d3e9f5e16fd79ffa796da29b7db4'
end