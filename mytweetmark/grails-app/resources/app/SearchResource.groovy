package app

import javax.ws.rs.GET
import javax.ws.rs.Path
import javax.ws.rs.Produces


@Path('/api/search')
class SearchResource {

    @GET
    @Produces('text/plain')
    String getSearchRepresentation() {
        'Search'
    }
    
}
