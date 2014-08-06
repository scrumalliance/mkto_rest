module MktoRest
  class Lead

    attr_reader :vars, :client
    attr_reader :id, :email     # as used in #update
    def initialize(client, args)
      @vars = []
      @client = client
      args.each do |k,v|
        @vars << k
        self.instance_variable_set("@#{k}", v)
      end
    end

    def method_missing(mthsym, *args)
      if @vars.include? mthsym
        return self.instance_variable_get("@#{mthsym}") if args.empty?
        self.instance_variable_set("@#{mthsym}", args[0])
      end
    end

    def update(args, attr = :id)
      if attr == :id
        @client.update_lead_by_id self.id, args
      elsif attr == :email
        @client.update_lead_by_email self.email, args
      end
    end

    def to_s
      @vars.map { |k| "#{k.inspect}=>#{self.send(k).inspect}" }.join(", ")
    end

  end
end
