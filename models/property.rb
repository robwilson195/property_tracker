require('pg')
class Property

  attr_accessor :address, :value, :number_bedrooms, :buy_let_status
  attr_reader :id

  def initialize(params)
    @id = params["id"].to_i unless params["id"].nil?
    @address = params["address"]
    @value = params["value"].to_i
    @number_bedrooms = params["number_bedrooms"].to_i
    @buy_let_status = params["buy_let_status"]
  end

  def save()
    db = PG.connect({dbname: "property_tracker", host: "localhost"})
    sql = "INSERT INTO properties
    (address, value, number_bedrooms, buy_let_status)
    VALUES ($1, $2, $3, $4)
    RETURNING *;"
    values = [@address, @value, @number_bedrooms, @buy_let_status]
    db.prepare("save", sql)
    row = db.exec_prepared("save", values)
    @id = row[0]["id"]
    db.close()
  end

  def update()
    db = PG.connect({dbname: "property_tracker", host: "localhost"})
    sql = "UPDATE properties SET (address, value, number_bedrooms, buy_let_status)
    = ($1, $2, $3, $4) WHERE id = $5;"
    values = [@address, @value, @number_bedrooms, @buy_let_status, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  def Property.delete_all()
    db = PG.connect({dbname: "property_tracker", host: "localhost"})
    sql = "DELETE FROM properties;"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end

  def delete()
    db = PG.connect({dbname: "property_tracker", host: "localhost"})
    sql = "DELETE FROM properties WHERE id = $1;"
    value = [@id]
    db.prepare("delete", sql)
    db.exec_prepared("delete", value)
    db.close()
  end

  def Property.find_by_id(id)
    db = PG.connect({dbname: "property_tracker", host: "localhost"})
    sql = "SELECT * FROM properties WHERE id = $1;"
    values = [id]
    db.prepare('find_by_id', sql)
    result = db.exec_prepared('find_by_id', values)
    db.close()
    return Property.new(result[0])
  end

  def Property.find_by_address(address)
    db = PG.connect({dbname: "property_tracker", host: "localhost"})
    sql = "SELECT * FROM properties WHERE address = $1;"
    values = [address]
    db.prepare('find_by_address', sql)
    result = db.exec_prepared('find_by_address', values)
    db.close()
    return Property.new(result[0])
  end

end
