class YomiyasuController < ApplicationController

  def index
    if request.post? then
      @memo = edit(params['input'])
      #msg = "
      #  <html>
      #  <body>
      #    <font color="red">#{src}red</font>
      #  </body>
      #  </html>
      #  "
      #render html: msg.html_safe
    else
      @memo = "この辺りに結果が表示されます。\nBefore　サンプル\n     C*********************************************************\n     C** 2.0     #CTL     ああ処理                         **\n     C*********************************************************\n     C           #CTL      BEGSR\n     C*\n     C                     READ FILEAAAA                 50\n     C           *IN50     DOWEQ*OFF                        \n     C                     Z-ADD*ZERO     IBAAAA\n     C                     MOVEL*BLANK    IBAAAA\n     C                     UPDATFILEAAAA\n     C                     READ FILEAAAA                 50\n     C                     ENDDO\n"
    end
  end

  def show
    if request.post? then
      input_text = params['input'].split("\n")
      body_text = []

      input_text.each do |ary|
        body_text << ary.split(',')
      end

      text_result =''
      body_text.each do |b|
        text_result += "<font color='#{b[1]}'>#{b[0]}</font><br>"
      end

      msg = "
        <html>
        <body>
          <p>#{text_result}</p>
          <font color='darkgray'>Inputした元データ→#{input_text}</font>
        </body>
        </html>
        "
      render html: msg.html_safe
    else
     # @test = ""
    end
  end


  private
  def edit(src)
    ary = src.split("\n")
    result = ''
    splat = 0                # flag
    ary.each do |line|
      if line =~ /^......\*/ # コメント行の場合
        if splat != 1
          result += "がんばって！" + "\n"
          splat = 1
        end
      elsif line =~ /.*BEGSR.*/ || line =~ /.*PLIST.*/ || line =~ /.*KLIST.*/
        result += "-" * 75 + "\n" + line
        splat = 0
      else
        result += line
        splat = 0
      end
    end
    return result
  end
end
