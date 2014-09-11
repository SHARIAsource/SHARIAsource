 class ErasController < ApplicationController
   def index
     @era_table = DocumentType.era_counts
   end
 end
