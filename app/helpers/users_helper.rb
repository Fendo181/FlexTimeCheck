module UsersHelper
  def hm(mins, display_sign: false)
    sign = mins <=> 0
    mins = mins.abs

    hours, mins = mins.divmod(60)
    (display_sign ? (sign >= 0 ? '+' : '-') : '') + (hours > 0 ? "#{hours}h" : '') + "#{mins}m"
  end

  def check_kintai(user_id, user_password)
    agent = Mechanize.new
    agent.user_agent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.84 Safari/537.36'
    agent.get('https://www.4628.jp/')

    agent.page.form_with(action: './') do |f|
      f['y_companycd'] = 'paperboy'
      f['y_logincd'] = user_id
      f['password'] = user_password
      f.submit
      # binding.pry
    end

    begin
      agent.page.link_with(href: /module=timesheet/).click
    rescue NoMethodError => ex
      @error_msg = 'ログインに失敗しました。残念! もう一度お試し下さい！'
      render 'home'
    end

    table = agent.page.xpath('id("submit_form0")/table').first
    columns = table.xpath('id("title_number1")/td').map(&:text)
    data = table.xpath('tr[@align="center"]').map{|tr| tr.xpath('td').map{|td| td.text.unistrip } }
    data = data.map {|row| columns.zip(row).to_h }
    # binding.pry

    uncounted_rest = data.select{|r| r['休憩時間'] == '00:00' }.map {|r| r['備考'] =~ /休憩(\d+)h/ ? $1.to_i * 60 : 0 }.inject(0, :+)
    escalation_weekdays = data.select{|r| r['カレンダー'] == '平日' }.map {|r| r['エス時間小計'].empty? ? 0 : r['エス時間小計'].parse_duration }.inject(0, :+)
    unaccepted_midnight = data.select{|r| r['カレンダー'] == '平日' && r['深夜時間'].empty? }.map {|r| d=r['退社'].empty? ? 0 : [r['退社'].parse_duration-22*60, 0].max }.inject(0, :+)

    worked_data = data.select {|r| r['カレンダー'] == '平日' && !r['実働時間'].empty? }
    worked = worked_data.map {|r| r['実働時間'].parse_duration }.inject(0, :+)
    days_worked = worked_data.count

    status = Hash[agent.page.xpath('id("total_list0")//tr').map {|tr| (tr / 'td').map {|e| e.text.unistrip } }.transpose]
    status = Hash[status.map {|k, v| [k, v =~ /\A\d*\z/ ? $&.to_i : v.parse_duration ] }]

    to_work = status['所定労働日数'] * 8*60 - (worked - uncounted_rest + escalation_weekdays)
    days_to_work = status['所定労働日数'] - days_worked
    diff = days_to_work * 8*60 - to_work

    @msg = "あと#{days_to_work}日 / #{hm(diff, display_sign: true)}"
    # msg << " (未承認" << hm(unaccepted_midnight, display_sign: true) << ")" if unaccepted_midnight > 0
  end
end
