class YomiyasuController < ApplicationController

  def index
  end

  def show
    if request.post? then
      input_text = params['input'].split("\n")
      body_text = []
      
      input_text.each do |ary|
        arywk = Array.new
        arywk << ary
        if ary =~ /^......\*/
          arywk << '#585858'
        elsif ary =~ /.*BEGSR.*/ || ary =~ /.*ENDSR.*/ || ary =~ /.*EXSR.*/
          arywk << '#58FAF4'
        elsif ary =~ /.*WRITE.*/ || ary =~ /.*UPDAT.*/ || ary =~ /.*DELET.*/
          arywk << '#FF4000'
        elsif ary =~ /.*IFEQ.*/ || ary =~ /.*ELSE.*/ || ary =~ /.*ENDIF.*/ || ary =~ /.*IFNE.*/ || ary =~ /.*IFLT.*/ || ary =~ /.*IFGT.*/ || ary =~ /.*IFLE.*/ || ary =~ /.*IFGE.*/
          arywk << '#FFFF00'
        elsif ary =~ /.*MOVE.*/ || ary =~ /.*Z-ADD.*/
          arywk << '#088A08'
        elsif ary =~ /.*DOW.*/ || ary =~ /.*ENDDO.*/
          arywk << '#FE2EF7'
        else
          arywk << '#F2F2F2'
        end
        body_text << arywk
      end

      text_result =''
      body_text.each do |b|
        text_result += "<font color='#{b[1]}'>#{b[0]}</font>"
      end

      msg = "
        <html>
        <body bgcolor='#2A0A22'>
          <pre>#{text_result}</pre>
      <!--  <p><font color='darkgray'>Inputした元データ→#{input_text}</font></p>
          <p><font color='darkgray'>body_text→#{body_text}</font></p> -->
        </body>
        </html>
        "
      render html: msg.html_safe
    else
     # @test = ""
    end
  end


end
