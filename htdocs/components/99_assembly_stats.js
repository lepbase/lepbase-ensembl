

 
function Assembly( stats,scaffolds ) { 
  var sum = scaffolds.reduce(function(previousValue, currentValue, index, array) {
  return previousValue + currentValue;
});
  this.assembly = stats.assembly; 
  this.N = stats.N ? stats.N < 100 ? stats.N < 1 ? stats.N : stats.N / 100 : stats.N / this.assembly : 0;
  this.ATGC = stats.ATGC ? stats.ATGC < 100 ? stats.ATGC < 1 ? stats.ATGC : stats.ATGC / 100 : stats.ATGC / this.assembly : 1 - this.N;
  this.GC = stats.GC < 100 ? stats.GC < 1 ? stats.GC * 100 : stats.GC : 50; // TODO: fix last condition 
  this.scaffolds = scaffolds.sort(function(a, b){return b-a});
  var npct = {};
  var npct_len = {};
  var lsum = 0;
  this.scaffolds.forEach(function(length,index,array){
	var new_sum = lsum + length;
	if (Math.floor(new_sum/sum*1000) > Math.floor(lsum/sum*100)){
		npct[Math.floor(new_sum/sum*1000)] = length;
		npct_len[Math.floor(new_sum/sum*1000)] = index;
	}
	lsum = new_sum;
  });
  this.seq = Array.apply(0, Array(1000)).map(function (x, y) { return 1000 - y; });
  this.seq.forEach(function(i,index){
  	if (!npct[i]) npct[i] = npct[(i+1)];
  	if (!npct_len[i]) npct_len[i] = npct_len[(i+1)];
  });
  this.npct = npct;
  this.npct_len = npct_len;
  this.scale = {};
  this.setScale('percent','linear',[0,100],[180* (Math.PI/180),90* (Math.PI/180)]);
  this.setScale('proportion','log',[1,1e5],[270* (Math.PI/180),360* (Math.PI/180)]);
  this.setScale('count','log',[1,1e6],[100,1]); // TODO: update range when drawing
  this.setScale('length','sqrt',[1,1e6],[1,100]); // TODO: update range when drawing
}

Assembly.prototype.setScale = function(element,scaling,domain,range){
  this.scale[element] = scaling == 'log' ? d3.scale.log() : scaling == 'sqrt' ? d3.scale.sqrt() : d3.scale.linear();
  this.scale[element].domain(domain);
  this.scale[element].range(range);
}

Assembly.prototype.drawPlot = function(parent,size,margin,tick){
  var radii = {};
  radii.core = [0,(size-margin*2-tick*2)/2];
  radii.core.majorTick = [radii.core[1],radii.core[1]+tick];
  radii.core.minorTick = [radii.core[1],radii.core[1]+tick/2];
  
  radii.proportion = [radii.core[1]+tick*8,radii.core[1]+tick*4];
  radii.proportion.majorTick = [radii.proportion[0],radii.proportion[0]+tick];
  radii.proportion.minorTick = [radii.proportion[0],radii.proportion[0]+tick/2];
  
  radii.percent = radii.proportion;
  radii.percent.majorTick = radii.proportion.majorTick;
  radii.percent.minorTick = radii.proportion.minorTick;
  
  this.radii = radii;
  
  this.scale['length'].domain([1,this.npct[1]])
  console.log(this.scale['length'].domain());
  this.scale['length'].range([radii.core[0],radii.core[1]])
  this.scale['count'].range([radii.core[1],radii.core[0]+radii.core[1]/3])
  //this.scale['count'].range([radii.core[0],radii.core[1]])
  console.log(this.scale['length'].range());
  var lScale = this.scale['length'];
  var cScale = this.scale['count'];
  var npct = this.npct;
  var npct_len = this.npct_len;
  var scaffolds = this.scaffolds;
  var g = parent.append('g')
      .attr("transform","translate("+size/2+","+size/2+")");
/*  var count_seq = Array.apply(0, Array(6)).map(function (x, y) { return Math.pow(10,y); });
  	count_seq.forEach(function(i,index){
  	  g.append('circle')
		.attr('r',radii.core[1] - cScale(i))
		.attr('class','axis');
    });*/
    
  this.seq.forEach(function(i,index){
  	if (i <= 1000){
  		var css = npct[i] == scaffolds[0] ? 'asm-longest_pie' : 'asm-pie';
  		plot_arc(g,radii.core[1] - lScale(npct[i]),radii.core[1],0,i * 360 / 1000 * (Math.PI/180),css);
  	  }
  });
  
    
  plot_arc(g,radii.core[1] - lScale(npct[500]),radii.core[1],0,500 * 360 / 1000 * (Math.PI/180),'asm-n50_pie');
  plot_arc(g,radii.core[1] - lScale(npct[900]),radii.core[1],0,900 * 360 / 1000 * (Math.PI/180),'asm-n90_pie');
  main_axis(g,radii);
  
  var power = 6;
  while (npct_len[1000] < Math.pow(10,power)){
  	power--;
  }
  this.seq.forEach(function(i,index){
  	if (i <= 1000){
  		//plot_arc(g,radii.core[1] - cScale(npct_len[i]),radii.core[1] - cScale(npct_len[i]),i * 360 / 1000 * (Math.PI/180),(i+1) * 360 / 1000 * (Math.PI/180),'count');
		plot_arc(g,radii.core[0],radii.core[1] - cScale(npct_len[i]),i * 360 / 1000 * (Math.PI/180),360 * (Math.PI/180),'asm-count');
  	  }
  });
  this.seq.forEach(function(i,index){
  	if (i <= 1000){
  		//plot_arc(g,radii.core[1] - cScale(npct_len[i]),radii.core[1] - cScale(npct_len[i]),i * 360 / 1000 * (Math.PI/180),(i+1) * 360 / 1000 * (Math.PI/180),'count');
		if (npct_len[i] < Math.pow(10,power)){
			console.log(i+' '+power);
			plot_arc(g,radii.core[1] - cScale(Math.pow(10,power)),radii.core[1] - cScale(Math.pow(10,power)),i * 360 / 1000 * (Math.PI/180),360 * (Math.PI/180),'asm-count_axis');
			power--;
		}
  	  }
  });
  
  
  var length_seq = [];
  var power = 2;
  while (Math.pow(10,power) <= this.npct[1]){
  	length_seq.push(power)
  	power++;
  }
  var lg = g.append("g")
		.attr("class","asm-length asm-axis");
  lg.append('line')
  		.attr('x1',0)
  		.attr('y1',-radii.core[1])
  		.attr('x2',0)
  		.attr('y2',0)
		//.attr("transform","translate(25,525)")
	//.call(length_axis);
  length_seq.forEach(function(i,index){
  		lg.append('line')
  		.attr('x1',0)
  		.attr('y1',-radii.core[1]+lScale(Math.pow(10,i)))
  		.attr('x2',-Math.pow(1.5,i))
  		.attr('y2',-radii.core[1]+lScale(Math.pow(10,i)))
        .attr('class', 'asm-majorTick');
  	});
  
  plot_arc(g,radii.proportion[0],radii.proportion[1],this.scale['proportion'](1),this.scale['proportion'](this.assembly/this.scaffolds[0]),'asm-genome');
  proportion_axis(g,radii,this.scale['proportion']);

  plot_arc(g,radii.percent[0],radii.percent[1],this.scale['percent'](0),this.scale['percent'](100),'asm-ns');
  plot_arc(g,radii.percent[0],radii.percent[1],this.scale['percent']((1-this.ATGC)/2*100),this.scale['percent'](100*this.ATGC + (1-this.ATGC)/2*100),'asm-atgc');
  plot_arc(g,radii.percent[0],radii.percent[1],this.scale['percent']((1-this.ATGC)/2*100),this.scale['percent'](this.GC),'asm-gc');
  percent_axis(g,radii,this.scale['percent']);


}

function main_axis (parent,radii){
	var g = parent.append('g');
	g.append('circle')
		.attr('r',radii.core[1])
		.attr('class','asm-axis');
	var seq = Array.apply(0, Array(50)).map(function (x, y) { return y * 7.2 * (Math.PI/180); });
  	seq.forEach(function(i,index){
  		var tick = d3.svg.arc()
      	.innerRadius(radii.core.minorTick[0])
        .outerRadius(radii.core.minorTick[1])
        .startAngle(i)
        .endAngle(i);
		g.append('path')
        .attr('d', tick)
        .attr('class', 'asm-minorTick');
  	});
  	var seq = Array.apply(0, Array(10)).map(function (x, y) { return y * 36 * (Math.PI/180); });
  	seq.forEach(function(i,index){
  		var tick = d3.svg.arc()
      	.innerRadius(radii.core.majorTick[0])
        .outerRadius(radii.core.majorTick[1])
        .startAngle(i)
        .endAngle(i);
		g.append('path')
        .attr('d', tick)
        .attr('class', 'asm-majorTick');
  	});
}

function proportion_axis (parent,radii,scale){
	var g = parent.append('g');
	var axis = d3.svg.arc()
      	.innerRadius(radii.proportion[0])
        .outerRadius(radii.proportion[0])
        .startAngle(scale(1) )
        .endAngle(scale(100000));
      g.append('path')
        .attr('d', axis)
        .attr('class', 'asm-axis');
  var seq = Array.apply(0, Array(6)).map(function (x, y) { return Math.pow(10,y); });
  seq.forEach(function(d){
    var arc = d3.svg.arc()
      			.innerRadius(radii.proportion.majorTick[0])
        		.outerRadius(radii.proportion.majorTick[1])
        		.startAngle(scale(d) )
        		.endAngle(scale(d));
  	g.append('path')
  		.attr('d',arc)
        .attr('class', 'asm-majorTick');
    });


	var minor = [];
    
  seq.forEach(function(d,index){
  	var tmp = Array.apply(0, Array(9)).map(function (x, y) { return d*(y+1) });
  	if (index < seq.length - 1)	minor = minor.concat(tmp);
  });
  
  minor.forEach(function(d){
    var arc = d3.svg.arc()
      			.innerRadius(radii.proportion.minorTick[0])
        		.outerRadius(radii.proportion.minorTick[1])
        		.startAngle(scale(d) )
        		.endAngle(scale(d));
  	g.append('path')
  		.attr('d',arc)
        .attr('class', 'asm-minorTick');
    });
    
  
	
}


function percent_axis (parent,radii,scale){
	var g = parent.append('g');
	var axis = d3.svg.arc()
      	.innerRadius(radii.percent[0])
        .outerRadius(radii.percent[0])
        .startAngle(scale(0) )
        .endAngle(scale(100));
      g.append('path')
        .attr('d', axis)
        .attr('class', 'asm-axis');
  var seq = Array.apply(0, Array(11)).map(function (x, y) { return y * 10; });
  seq.forEach(function(d){
    var arc = d3.svg.arc()
      			.innerRadius(radii.percent.majorTick[0])
        		.outerRadius(radii.percent.majorTick[1])
        		.startAngle(scale(d) )
        		.endAngle(scale(d));
  	g.append('path')
  		.attr('d',arc)
        .attr('class', 'asm-majorTick');
    });


	var seq = Array.apply(0, Array(50)).map(function (x, y) { return y*2; });
  seq.forEach(function(d){
    var arc = d3.svg.arc()
      			.innerRadius(radii.percent.minorTick[0])
        		.outerRadius(radii.percent.minorTick[1])
        		.startAngle(scale(d) )
        		.endAngle(scale(d));
  	g.append('path')
  		.attr('d',arc)
        .attr('class', 'asm-minorTick');
    });

    
  
	
}


function plot_arc (parent,inner,outer,start,end,css){
	var arc = d3.svg.arc()
      	.innerRadius(inner)
        .outerRadius(outer)
        .startAngle(start)
        .endAngle(end);
      parent.append('path')
        .attr('d', arc)
        .attr('class', css);
}


