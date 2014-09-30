require 'optparse'
require './checkermatrix.rb'
require 'pp'

class ImpossibleError < StandardError; end

def solve(m)
	costs = []
	# 010101..と101010..の2種類と、縦0開始、横1開始のようにゴールが入れ替わるパターンを調べる
	# これによってケース87が1手減る
	[true, false].repeated_permutation(2) do |zero_origin_column, zero_origin_row|
	#[[true, true], [false, false]].each do |zero_origin_column, zero_origin_row| # 無効化
		begin
			# うまくcloneできない
			xm = Matrix.rows m.row_vectors
			xm.scale = m.scale

			cost = sort(xm, true,  zero_origin_column)
			cost += sort(xm, false, zero_origin_row)
			#sort()は[1,x]か[x,1]の要素でしか判定していないので、それ以下の要素がずれているパターンがある
			#その場合はどうやっても修正できないのでIMPOSSIBLEとなる
			unless xm.verify? # or true # 無効化
				puts "Verification failed." if $verbose
				xm.show if $verbose
				raise ImpossibleError.new
			end
			costs << cost
		rescue ImpossibleError => e
		ensure
			xm = nil
		end
	end
	# 両方とも解法がなかったらimpossible
	raise ImpossibleError.new if costs.empty?
	#p costs
	costs.min
end

# ゴールとの差分をとって-1のものと1のペアを入れ替える
# vertical: 縦方向に対する操作。falseを指定すると横方向の操作
# zero_origin: true: 01010101.. の配列, false: 10101010..の配列
def sort(m, vertical, zero_origin)
	cost = 0
	diff = m - Matrix.goal(m.scale, zero_origin)
	swap_pair = [[],[]] #差分が-1のものを0番目の要素に、差分が1のものを1番目の要素に入れる
	diff.row_size.times do |i|
		x = vertical ? diff[0, i] : diff[i, 0]
		next if x==0
		swap_pair[x==-1?0:1] << i
	end
	print "#{vertical ? 'c' : 'r'}#{zero_origin ? '0' : '1'}" if $verbose
	pp swap_pair if $verbose
	# 入れ替えられない判定をここで行う。計算量は多いが楽をするため。
	raise ImpossibleError.new if swap_pair[0].empty? ^ swap_pair[1].empty? #ケース2のように入れ替えゼロのことがあるのでxorをとる
	raise ImpossibleError.new if swap_pair[0].size != swap_pair[1].size
	#scale/2回以上交換する解はおかしい
	# pp swap_pair if (m.scale / 2) < swap_pair[0].size or (m.scale / 2) < swap_pair[0].size
	swap_pair[0].size.times do |i|
		if vertical
			m.swap_column!(swap_pair[0][i], swap_pair[1][i])
		else
			m.swap_row!(swap_pair[0][i], swap_pair[1][i])
		end
		cost += 1
	end
	cost
end


options = ARGV.getopts('f:vm')
if options['f'].nil? or !File.exist?(options['f'])
	puts "file #{options['f']} not found."
	puts ""
	puts "usage: ruby ./checkerboard.rb -f problem.txt"
	puts "arguments:"
	puts "  -f filename     specify problem text file"
	puts "  -v              verbose"
	puts "  -m              print all matrix"
	puts "example: solve A-small-practice"
	puts "  ruby ./checkerboard.rb -f ../input/A-small-practice.in > result.txt"
	puts ""
	exit
end
$verbose = options['v']

max_case = 0
current_case = 1
line_count = 0
scale = 0
rows = []
IO.foreach(options['f']) do |line|
	line.strip!
	if max_case == 0
		max_case = line.to_i
		next
	end
	if line_count == 0
		rows = []
		scale = line.to_i
		line_count = scale * 2
		next
	end
    rows << line.chars.map{|x| x.to_i}
	line_count -= 1

	if line_count == 0
		m = Matrix.rows rows
		m.scale = scale
		begin
			cost = solve(m)
		rescue ImpossibleError => e
			cost = 'IMPOSSIBLE'
		end
		m.show if options['m']
		#puts "#{cost}"
		puts "Case ##{current_case}: #{cost}"
		current_case += 1
	end
end
