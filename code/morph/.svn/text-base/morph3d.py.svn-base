#!/usr/bin/env python

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# This module contains the class Morph3dModels, which allows morphing two 3d models built with POVray and
# whose geoometry is specified in file "_geom.inc" file.
#
# The models should be stored in 2 folders (e.g., WIDER_FACE and NARROW_FACE), containing all the files
# required to render the models.
#
# The method ".process()" should be used to generate the morph stimuli. This method call other methods to
# do the following (in order):
# 1) load the files "_geom.inc" containing the models (the full path should be provided)
# 2) parse each file and build, for each model, a list of model elements (e.g., eyes, skin, etc.)
# 3) morph the two models
# 4) write a new "_geom.inc" file for the resulting model (NOTE: the name of this file is "FACE_POV_geom.inc")
# 5) render the morph model by executing a POVray command string
#
# NOTE: in order to be able to render the model, all the files staring with "FACE" must be in the folder where the module is locates 
#
# Example:
# 
# import morph3d
# FaceNames = {'model1': '../POVRAY/Faces/NARROW_BETTER/NARROW_BETTER_POV_geom.inc', 'model2': '../POVRAY/Faces/WIDE_FACE/WIDE_FACE_POV_geom.inc'}
# tmp2 = morph3d.Morph3dModels()
#
# # this next build a blend with -50% object 2 (i.e., extrapolate beyond object 1), with the texture taken from object 1, and a default frame size (791x652):
# tmp2.process(FaceNames4, morph_frac_obj2=-0.5, _model2choose_for_uneq_array=1, _mfact_def_frame=1 )
#
# # this next build a blend with 150% object 2 (i.e., extrapolate beyond object 2), with the texture taken from object 2, and 2.5x the default frame size (791x652):
# tmp2.process(FaceNames4, morph_frac_obj2=1.5, _model2choose_for_uneq_array=2, _mfact_def_frame=2.5 )
#
# # this next build a whole sequence of objects extrapolated beyond object (prototype) 2:
# tmp2.build_morph_line(FaceNames, morph_frac_obj2_start = 1.0, morph_frac_obj2_end = 1.5, morph_frac_obj2_step = 0.1, _model2choose_for_uneq_array = "closest", \
# _mfact_def_frame=2.5, _out_folder = "output_morph_N2/" )
#
# NOTE: to resize the generated morphed object use the matlab function "ResizeMorphedFacesRatStims"
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


import Povray as pov
import os
from PIL import Image
from scipy import *
from pylab import *
from numpy import *
from pyparsing import *
import cPickle


# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  class: Morph3dModels  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 
class Morph3dModels:
    
    # ==================================== method: __init__ ========================================
    def __init__( self ):
        
        # File contents (these are string)
        self.file1 = None
        self.file2 = None
        # Paths to model files
        self.path1 = None
        self.path2 = None
        # Raw file names ("inc")
        self.filename1 = None
        self.filename2 = None
        # Preprocessed file names ("pic")
        self.filename1_pic = None
        self.filename2_pic = None
        
        # Initialize lists with the geometrical elemenets of each object (i.e., eyes, skin, etc)
        self.model1_elements = []
        self.model2_elements = []
        self.morph_model_elements = []
        
        # Some Mmorph and rendering variables
        self.model2choose_for_uneq_array = 1
        self.def_frame_width = 791
        self.def_frame_height = 652
        self.mfact_def_frame = 1


    # ==================================== method: process ========================================
    def process( self, inputFiles, morph_frac_obj2 = 0.5, _model2choose_for_uneq_array = 1, _mfact_def_frame = 1, _out_name = "test_morph.png", \
            _out_folder = "output_morph/" ):

        self.mfact_def_frame = _mfact_def_frame
        self.model2choose_for_uneq_array = _model2choose_for_uneq_array      

        self.load_model_files( inputFiles )
        self.parse_single_file( 1 )
        self.parse_single_file( 2 )
        self.morph( morph_frac_obj2 )
        self.write_geom_file( "morphed" )
        self.render_model( out_name = _out_name, out_folder = _out_folder )


        
    # ==================================== method: build_morph_line ========================================
    def build_morph_line( self, inputFiles, morph_frac_obj2_start = 1.0, morph_frac_obj2_end = 1.5, morph_frac_obj2_step = 0.1, \
            _model2choose_for_uneq_array = "closest", _mfact_def_frame = 1, _out_folder = "output_morph/" ):

        if _model2choose_for_uneq_array == "obj1":
            self.model2choose_for_uneq_array = 1
        elif _model2choose_for_uneq_array == "obj2":
            self.model2choose_for_uneq_array = 2
        elif _model2choose_for_uneq_array == "closest":
            print "for each individual morphed object, choose the closest model (prototype) for unequal arrays"
        else:
            raise Exception, "The \"_model2choose_for_uneq_array\" value \"" + _model2choose_for_uneq_array + "\" is not supported!"

        self.mfact_def_frame = _mfact_def_frame
        
        self.load_model_files( inputFiles )
        self.parse_single_file( 1 )
        self.parse_single_file( 2 )

        # Fixed chunks of the output name (to be changed by the user as he likes them)
        name_chunk1 = "FACE_"
        name_chunk2 = "_CamRot_y0_"
        
        # Loop along the morphline
        for morph_frac_obj2 in arange( morph_frac_obj2_start, morph_frac_obj2_end+0.01, morph_frac_obj2_step ):
            
            # Decide if the object is closer to prototype 1 or 2: name it accordingly and choose the proper model for the unequal arrays
            if morph_frac_obj2 >= 0.5:
                obj_name = "2"
                if _model2choose_for_uneq_array == "closest":
                    self.model2choose_for_uneq_array = 2
            else:
                obj_name = "1"
                if _model2choose_for_uneq_array == "closest":
                    self.model2choose_for_uneq_array = 1
            _out_name = name_chunk1 + obj_name + name_chunk2 + "morph" + str(morph_frac_obj2) + ".png"
            
            self.morph( morph_frac_obj2 )
            self.write_geom_file( "morphed" )
            self.render_model( out_name = _out_name, out_folder = _out_folder )



    # ==================================== method: load_model_files ========================================
    def load_model_files( self, inputFiles = None ):
        
        if( inputFiles != None ):
            
            # Model 1
            if( inputFiles.has_key( 'model1' ) and inputFiles['model1'] is not None ):
                
                # Find the path to the file and the file name
                i_slash = findstr( inputFiles['model1'], "/" )
                if len(i_slash) > 0:
                    self.path1 = inputFiles['model1'][:i_slash[-1]+1]
                    self.filename1 = inputFiles['model1'][i_slash[-1]+1:]
                else:
                    self.path1 = "./"    
                    self.filename1 = inputFiles['model1']                   
                print "\nGeometrical model 1:"
                print "path: " + self.path1
                print "file name: " + self.filename1
                
                # If a preprocessed "pic" file exists, load it instead of the "inc" file
                i_inc = self.filename1.find(".inc")
                self.filename1_pic = self.filename1[:i_inc] + ".pic"
                try:
                    f1 = open( self.path1 + self.filename1_pic, 'r')
                    self.model1_elements = cPickle.load( f1 )
                    print "... loading the preprocessed data file: " + self.filename1_pic
                except:
                    f1 = open( inputFiles['model1'], 'r' )
                    self.file1 = f1.read()
                    print "... loading the \"inc\" data file: " + self.filename1
                f1.close()
                
            else:
                raise Exception, "The file name of the FIRST model is MISSING!"
            
            
            # Model 2
            if( inputFiles.has_key( 'model2' ) and inputFiles['model2'] is not None ):
                
                # Find the path to the file and the file name
                i_slash = findstr( inputFiles['model2'], "/" )
                if len(i_slash) > 0:
                    self.path2 = inputFiles['model2'][:i_slash[-1]+1]
                    self.filename2 = inputFiles['model2'][i_slash[-1]+1:]
                else:
                    self.path2 = "./"    
                    self.filename2 = inputFiles['model2']                   
                print "\nGeometrical model 2:"
                print "path: " + self.path2
                print "file name: " + self.filename2
                
                # If a preprocessed "pic" file exists, load it instead of the "inc" file
                i_inc = self.filename2.find(".inc")
                self.filename2_pic = self.filename2[:i_inc] + ".pic"
                try:
                    f2 = open( self.path2 + self.filename2_pic, 'r')
                    self.model2_elements = cPickle.load( f2 )
                    print "... loading the preprocessed data file: " + self.filename2_pic
                except:
                    f2 = open( inputFiles['model2'], 'r' )
                    self.file2 = f2.read()
                    print "... loading the \"inc\" data file: " + self.filename2
                f2.close()
                                
            else:
                print "The file name of the SECOND model is MISSING!"
                # raise Exception, "The file name of the SECOND model is MISSING!"
                            
            
    # ==================================== method: parse_single_file ========================================
    def parse_single_file( self, model ):
        
        curr_model_elements = []    
        if model == 1:
            if len(self.model1_elements) == 0:
                curr_file = self.file1
            else:
                curr_file = None
                curr_filename = self.filename1
        if model == 2:
            if len(self.model2_elements) == 0:
                curr_file = self.file2
            else:
                curr_file = None
                curr_filename = self.filename2
        
        # Parse the raw "inc" file
        if curr_file is not None:    
            
            # ######## Define the grammars #########
            # First level: literals and strings
            curled_brace_close = Word("}").setResultsName("curled_brace_close") 
            comma = Literal(",").suppress()
            declare_lit = Literal("#declare")
            mesh2_lit = Literal("=mesh2{")
            vertex_vectors_lit = Literal("vertex_vectors")
            normal_vectors_lit = Literal("normal_vectors")
            uv_vectors_lit = Literal("uv_vectors")
            face_indices_lit = Literal("face_indices")
            uv_indices_lit = Literal("uv_indices")
            normal_indices_lit = Literal("normal_indices")
            # First level: data
            num_float = Word(nums+".-E").setParseAction( lambda tokens: float(tokens[0]))
            num_int = Word(nums).setParseAction( lambda tokens: int(tokens[0]))
            n_points = Word(nums).setParseAction( lambda tokens: int(tokens[0]))
            # Second level
            model_element = declare_lit + Word(alphanums+'_+{').setResultsName("element_name") + mesh2_lit
            num3d_float = Group( Literal("<").suppress() + num_float + comma + num_float + comma + num_float + Literal(">").suppress() ).setResultsName("list3d_float")
            num2d_float = Group( Literal("<").suppress() + num_float + comma + num_float + Literal(">").suppress() ).setResultsName("list2d_float")
            num3d_int = Group( Literal("<").suppress() + num_int + comma + num_int + comma + num_int + Literal(">").suppress() ).setResultsName("list3d_int")
                
                
            # ######## Parse the file line by line #########
            vertex_vectors = array([])
            normal_vectors = array([])
            uv_vectors = array([])
            face_indices = array([])
            uv_indecaes = array([])
            flag_prev_line_closed_brace = 0
        
            # Loop on each line
            for line in curr_file.splitlines():
            
                # ******** Retrieve the model element (e.g., eye, skin, etc) *********
                try:
                    result = model_element.parseString(line)
                    tmp = Element3dModel()
                    tmp.element_name = result.element_name
                    curr_model_elements.append( tmp )
                    print "\n---------- Model element:", curr_model_elements[-1].element_name, "-------------"
                except ParseException:
                    pass
                except Exception, e:
                    raise Exception, e
            
                # ******** Retrieve the literals (i.e., the names of the arrays containing the 3d model structure) ********* 
                # Retrieve the "vertex_vectors" literal
                try:
                    result = ( vertex_vectors_lit.setResultsName("data_name") + Word('{').suppress() ).parseString(line)
                    vertex_vectors = zeros( (1,3) )
                    print "\nData array:", result.data_name
                except ParseException:
                    pass
                except Exception, e:
                    raise Exception, e
                
                # Retrieve the "normal_vectors" literal ...
                try:
                    result = ( normal_vectors_lit.setResultsName("data_name") + Word('{').suppress() ).parseString(line)
                    normal_vectors = zeros( (1,3) )
                    # Save the previous array as an attribute of the model elements object (delete first its first row)
                    vertex_vectors = delete( vertex_vectors, 0, 0 )
                    curr_model_elements[-1].vertex_vectors = vertex_vectors.copy()
                    curr_model_elements[-1].check_consist_array_dim( "vertex_vectors" )
                    vertex_vectors = array([])
                    print "\nData array:", result.data_name
                except ParseException:
                    pass
                except Exception, e:
                    raise Exception, e
            
                # Retrieve the "uv_vectors" literal ...
                try:
                    result = ( uv_vectors_lit.setResultsName("data_name") + Word('{').suppress() ).parseString(line)
                    uv_vectors = zeros( (1,2) )
                    # Save the previous array as an attribute of the model elements object (delete first its first row)
                    normal_vectors = delete( normal_vectors, 0, 0 )
                    curr_model_elements[-1].normal_vectors = normal_vectors.copy()
                    curr_model_elements[-1].check_consist_array_dim( "normal_vectors" )
                    normal_vectors = array([])
                    print "\nData array:", result.data_name
                except ParseException:
                    pass
                except Exception, e:
                    raise Exception, e
                
                # Retrieve the "face_indices" literal ...
                try:
                    result = ( face_indices_lit.setResultsName("data_name") + Word('{').suppress() ).parseString(line)
                    face_indices = zeros( (1,3), int )
                    # Save the previous array as an attribute of the model elements object (delete first its first row)
                    uv_vectors = delete( uv_vectors, 0, 0 )
                    curr_model_elements[-1].uv_vectors = uv_vectors.copy()
                    curr_model_elements[-1].check_consist_array_dim( "uv_vectors" )
                    uv_vectors = array([])
                    print "\nData array:", result.data_name
                except ParseException:
                    pass
                except Exception, e:
                    raise Exception, e
            
                # Retrieve the "uv_indices" literal ...
                try:
                    result = ( uv_indices_lit.setResultsName("data_name") + Word('{').suppress() ).parseString(line)
                    uv_indices = zeros( (1,3), int )
                    # Save current array as an attribute of the model elements object (delete first its first row)
                    face_indices = delete( face_indices, 0, 0 )
                    curr_model_elements[-1].face_indices = face_indices.copy()
                    curr_model_elements[-1].check_consist_array_dim( "face_indices" )
                    face_indices = array([])
                    print "\nData array:", result.data_name
                except ParseException:
                    pass
                except Exception, e:
                    raise Exception, e

                # Retrieve the "normal_indices" literal ...
                try:
                    result = ( normal_indices_lit.setResultsName("data_name") + Word('{').suppress() ).parseString(line)
                    normal_indices = zeros( (1,3), int )
                    # Save current array as an attribute of the model elements object (delete first its first row)
                    uv_indices = delete( uv_indices, 0, 0 )
                    curr_model_elements[-1].uv_indices = uv_indices.copy()
                    curr_model_elements[-1].check_consist_array_dim( "uv_indices" )
                    uv_indices = array([])
                    print "\nData array:", result.data_name
                except ParseException:
                    pass
                except Exception, e:
                    raise Exception, e
        
                # Retrieve the "curled_brace_close" word
                # NOTE: two consecutive occurrences are used to detect the termination of a model element
                try:
                    result = curled_brace_close.parseString(line)
                    if flag_prev_line_closed_brace == 1:
                        # Save current array as an attribute of the model elements object (delete first its first row)
                        normal_indices = delete( normal_indices, 0, 0 )
                        curr_model_elements[-1].normal_indices = normal_indices.copy()
                        curr_model_elements[-1].check_consist_array_dim( "normal_indices" )
                        normal_indices = array([])
                    else:
                        flag_prev_line_closed_brace = 1
                    # print result.curled_brace_close # debug print
                except ParseException:
                    flag_prev_line_closed_brace = 0
                    pass
                except Exception, e:
                    raise Exception, e
                
                # ******** Retrieve the structural data ********
                # Retrieve the number of elements in a data array
                try:
                    result = ( num_int.setResultsName("n_data") + comma ).parseString(line)
                    if vertex_vectors.shape[0] > 0:
                        curr_model_elements[-1].vertex_vectors_n = result.n_data
                    elif normal_vectors.shape[0] > 0:
                        curr_model_elements[-1].normal_vectors_n = result.n_data
                    elif uv_vectors.shape[0] > 0:
                        curr_model_elements[-1].uv_vectors_n = result.n_data
                    elif face_indices.shape[0] > 0:
                        curr_model_elements[-1].face_indices_n = result.n_data
                    elif uv_indices.shape[0] > 0:
                        curr_model_elements[-1].uv_indices_n = result.n_data
                    elif normal_indices.shape[0] > 0:
                        curr_model_elements[-1].normal_indices_n = result.n_data    
                    print "# data =", result.n_data
                except ParseException:
                    pass
                except Exception, e:
                    raise Exception, e
            
                # Retrieve 3d float data
                try:
                    result = num3d_float.parseString(line)
                    if vertex_vectors.shape[0] > 0:
                        vertex_vectors = vstack( (vertex_vectors, result.list3d_float[:]) )
                    elif normal_vectors.shape[0] > 0:
                        normal_vectors = vstack( (normal_vectors, result.list3d_float[:]) )
                except ParseException:
                    # # For debug: print the lines that were skipped
                    # if vertex_vectors.shape[0] > 0:
                    #     print "line skipped in vertex_vectors:", line
                    # elif normal_vectors.shape[0] > 0:
                    #     print "line skipped in normal_vectors:", line                
                    pass
                except Exception, e:
                    raise Exception, e
            
                # Retrieve 2d float data
                try:
                    result = num2d_float.parseString(line)
                    if uv_vectors.shape[0] > 0:
                        uv_vectors = vstack( (uv_vectors, result.list2d_float[:]) )
                except ParseException:
                    pass
                except Exception, e:
                    raise Exception, e
                        
                # Retrieve 3d int data
                try:
                    result = num3d_int.parseString(line)
                    if face_indices.shape[0] > 0:
                        face_indices = vstack( (face_indices, result.list3d_int[:]) )
                    elif uv_indices.shape[0] > 0:
                        uv_indices = vstack( (uv_indices, result.list3d_int[:]) )
                    elif normal_indices.shape[0] > 0:
                        normal_indices = vstack( (normal_indices, result.list3d_int[:]) )
                except ParseException:
                    pass
                except Exception, e:
                    raise Exception, e
                
                
            # ###### Debug prints ########
            flag_debug_print = 0
            if flag_debug_print:
                print curr_model_elements[-1].vertex_vectors
                print curr_model_elements[-1].vertex_vectors_n      
                print curr_model_elements[-1].normal_vectors
                print curr_model_elements[-1].normal_vectors_n   
                print curr_model_elements[-1].uv_vectors
                print curr_model_elements[-1].uv_vectors_n   
                print curr_model_elements[-1].face_indices
                print curr_model_elements[-1].face_indices_n   
                print curr_model_elements[-1].uv_indices
                print curr_model_elements[-1].uv_indices_n   
                print curr_model_elements[-1].normal_indices
                print curr_model_elements[-1].normal_indices_n   
        
        
            # ####### Save the model elements object in the proper attribute of the Morph3dModels object and in a "pic data file" #######
            if( model == 1 ):
                self.model1_elements = curr_model_elements
            
                f1 = open( self.path1 + self.filename1_pic, 'w')
                cPickle.dump( curr_model_elements, f1 )
                print "\n... saving the resulting of parsing into the preprocessed data file: " + self.filename1_pic
                f1.close()
            
            elif( model == 2 ):
                self.model2_elements = curr_model_elements
            
                f2 = open( self.path2 + self.filename2_pic, 'w')
                cPickle.dump( curr_model_elements, f2 )
                print "\n... saving the resulting of parsing into the preprocessed data file: " + self.filename2_pic
                f2.close()
        
        # Non need to parse the file ...
        else:
            print "\nNO need to parse the file: " + curr_filename + ": a list of geometrical elements for the current model alreay exist!"
            
            
    # ==================================== method: write_geom_file ========================================
    def write_geom_file( self, model = "morphed" ):
        
        if model == "morphed":
            curr_model_elements = self.morph_model_elements
        elif model == "first":
            curr_model_elements = self.model1_elements
        elif model == "second":
            curr_model_elements = self.model2_elements
        else:
            raise Exception, "The model name \"" + model + "\" is not supported!"
            
        # Retrive model's name and build the corresponding file name
        i_eye = curr_model_elements[0].element_name.find("_eye")
        base_name = curr_model_elements[0].element_name[:i_eye]
        geom_file = base_name + "_POV_geom.inc"
        
        if curr_model_elements:
            print "\n --------- Start writing the morphed geometrical file ---------"
            f = open( geom_file, 'w')
        
            # Header
            f.write("//POV-Ray Geometry mesh list\n\n")
            f.write("//Materials\n")
            f.write("#include \"" + base_name + "_POV_mat.inc\"\n\n")
            f.write("//Geometry\n")
        
            # Loop on all the elements of the geometrical model (i.e., eyes, mouth, teeth, skin, etc)
            for elem in curr_model_elements:
            
                f.write( "#declare " + elem.element_name + "=mesh2{\n" )
                print "\n... wriitng " + elem.element_name + " elements"
            
                # vertex vectors
                f.write("vertex_vectors{\n")
                print "-> vertex_vectors (" + str(elem.vertex_vectors_n) + ")"
                f.write( str(elem.vertex_vectors_n) + ",\n" )
                for i in xrange(elem.vertex_vectors_n-1):
                    f.write( "<" + str(elem.vertex_vectors[i][0]) + "," + str(elem.vertex_vectors[i][1]) + "," + str(elem.vertex_vectors[i][2]) + ">,\n" )
                f.write( "<" + str(elem.vertex_vectors[i+1][0]) + "," + str(elem.vertex_vectors[i+1][1]) + "," + str(elem.vertex_vectors[i+1][2]) + ">\n" )
                f.write("}\n")

                # normal vectors
                f.write("normal_vectors{\n")
                print "-> normal_vectors (" + str(elem.normal_vectors_n) + ")"
                f.write( str(elem.normal_vectors_n) + ",\n" )
                for i in xrange(elem.normal_vectors_n-1):
                    f.write( "<" + str(elem.normal_vectors[i][0]) + "," + str(elem.normal_vectors[i][1]) + "," + str(elem.normal_vectors[i][2]) + ">,\n" )
                f.write( "<" + str(elem.normal_vectors[i+1][0]) + "," + str(elem.normal_vectors[i+1][1]) + "," + str(elem.normal_vectors[i+1][2]) + ">\n" )
                f.write("}\n")

                # uv vectors
                f.write("uv_vectors{\n")
                print "-> uv_vectors (" + str(elem.uv_vectors_n) + ")"
                f.write( str(elem.uv_vectors_n) + ",\n" )
                for i in xrange(elem.uv_vectors_n-1):
                    f.write( "<" + str(elem.uv_vectors[i][0]) + "," + str(elem.uv_vectors[i][1]) + ">,\n" )
                f.write( "<" + str(elem.uv_vectors[i+1][0]) + "," + str(elem.uv_vectors[i+1][1]) + ">\n" )
                f.write("}\n")

                # face indices
                f.write("face_indices{\n")
                print "-> face_indices (" + str(elem.face_indices_n) + ")"
                f.write( str(elem.face_indices_n) + ",\n" )
                for i in xrange(elem.face_indices_n-1):
                    f.write( "<" + str(elem.face_indices[i][0]) + "," + str(elem.face_indices[i][1]) + "," + str(elem.face_indices[i][2]) + ">,\n" )
                f.write( "<" + str(elem.face_indices[i+1][0]) + "," + str(elem.face_indices[i+1][1]) + "," + str(elem.face_indices[i+1][2]) + ">\n" )
                f.write("}\n")
        
                # uv indices
                f.write("uv_indices{\n")
                print "-> uv_indices (" + str(elem.uv_indices_n) + ")"
                f.write( str(elem.uv_indices_n) + ",\n" )
                for i in xrange(elem.uv_indices_n-1):
                    f.write( "<" + str(elem.uv_indices[i][0]) + "," + str(elem.uv_indices[i][1]) + "," + str(elem.uv_indices[i][2]) + ">,\n" )
                f.write( "<" + str(elem.uv_indices[i+1][0]) + "," + str(elem.uv_indices[i+1][1]) + "," + str(elem.uv_indices[i+1][2]) + ">\n" )    
                f.write("}\n")
            
                # normal indices
                f.write("normal_indices{\n")
                print "-> normal_indices (" + str(elem.normal_indices_n) + ")"
                f.write( str(elem.normal_indices_n) + ",\n" )
                for i in xrange(elem.normal_indices_n-1):
                    f.write( "<" + str(elem.normal_indices[i][0]) + "," + str(elem.normal_indices[i][1]) + "," + str(elem.normal_indices[i][2]) + ">,\n" )
                f.write( "<" + str(elem.normal_indices[i+1][0]) + "," + str(elem.normal_indices[i+1][1]) + "," + str(elem.normal_indices[i+1][2]) + ">\n" )
                f.write("}\n")
            
                f.write("}\n\n")
        
            # Wrap it up
            f.write("\n//Model assembly from the meshes\n")
            f.write( "#declare " + base_name + "_=\n")
            f.write("union{\n")
            for elem in curr_model_elements:
                i_texture = elem.element_name.find("Texture")
                f.write( "object{" + elem.element_name + " material{" + elem.element_name[i_texture:] + "}}\n" )
            f.write("}\n")
        
            f.close()

        else:
            raise Exception, "The model \"" + model + "\" is currently None"


    # ==================================== method: morph ========================================
    def morph( self, morph_frac_obj2 = 0.5 ):
                
        if self.model1_elements and self.model2_elements:
            
            # Morphing coefficients
            c1 = 1 - morph_frac_obj2
            c2 = morph_frac_obj2
            
            # Find the index where the suffixes (e.g., "_eyeL_hi_Texture0_") of model1's elements (e.g., "NARROW_BETTER_eyeL_hi_Texture0_") start
            i_suff = self.model1_elements[0].element_name.find("_eye")            
        
            # Loop on all the elements of the geometrical models (i.e., eyes, mouth, teeth, skin, etc)
            self.morph_model_elements = []
            for n in xrange( len(self.model1_elements) ):
                tmp_model_elements = Element3dModel()
                tmp_model_elements.element_name = "FACE" + self.model1_elements[n].element_name[i_suff:]
                print "\nElement name: " + tmp_model_elements.element_name
                
                # Morph vertex_vectors
                if self.model1_elements[n].vertex_vectors_n == self.model2_elements[n].vertex_vectors_n:
                    print "... morph the vertex vectors (" + str(self.model1_elements[n].vertex_vectors_n) + ")"
                    tmp_model_elements.vertex_vectors = c1*self.model1_elements[n].vertex_vectors + c2*self.model2_elements[n].vertex_vectors
                    tmp_model_elements.vertex_vectors_n = self.model1_elements[n].vertex_vectors_n
                else:
                    print "WARNING: the vertex vectors CANNOT be morphed because have different dimensions: " + str(self.model1_elements[n].vertex_vectors_n) + \
                    "(model 1), " + str(self.model2_elements[n].vertex_vectors_n) + "(model 2)"
                    if self.model2choose_for_uneq_array == 1:
                        print "\t the vertex vectors of the FIRST model will be used for \"morphed\" model" 
                        tmp_model_elements.vertex_vectors = self.model1_elements[n].vertex_vectors
                        tmp_model_elements.vertex_vectors_n = self.model1_elements[n].vertex_vectors_n
                    elif self.model2choose_for_uneq_array == 2:
                        print "\t the vertex vectors of the SECOND model will be used for \"morphed\" model" 
                        tmp_model_elements.vertex_vectors = self.model2_elements[n].vertex_vectors
                        tmp_model_elements.vertex_vectors_n = self.model2_elements[n].vertex_vectors_n
                
                # Morph normal_vectors
                if self.model1_elements[n].normal_vectors_n == self.model2_elements[n].normal_vectors_n:
                    print "... morph the normal vectors (" + str(self.model1_elements[n].normal_vectors_n) + ")"
                    tmp_model_elements.normal_vectors = c1*self.model1_elements[n].normal_vectors + c2*self.model2_elements[n].normal_vectors
                    tmp_model_elements.normal_vectors_n = self.model1_elements[n].normal_vectors_n    
                else:
                    print "WARNING: the normal vectors CANNOT be morphed because have different dimensions: " + str(self.model1_elements[n].normal_vectors_n) + \
                    "(model 1), " + str(self.model2_elements[n].normal_vectors_n) + "(model 2)"
                    if self.model2choose_for_uneq_array == 1:
                        print "\t the normal vectors of the FIRST model will be used for \"morphed\" model" 
                        tmp_model_elements.normal_vectors = self.model1_elements[n].normal_vectors
                        tmp_model_elements.normal_vectors_n = self.model1_elements[n].normal_vectors_n    
                    elif self.model2choose_for_uneq_array == 2:
                        print "\t the normal vectors of the SECOND model will be used for \"morphed\" model" 
                        tmp_model_elements.normal_vectors = self.model2_elements[n].normal_vectors
                        tmp_model_elements.normal_vectors_n = self.model2_elements[n].normal_vectors_n    
                    
                # Morph uv_vectors
                if self.model1_elements[n].uv_vectors_n == self.model2_elements[n].uv_vectors_n:
                    print "... morph the uv vectors (" + str(self.model1_elements[n].uv_vectors_n) + ")"
                    tmp_model_elements.uv_vectors = c1*self.model1_elements[n].uv_vectors + c2*self.model2_elements[n].uv_vectors
                    tmp_model_elements.uv_vectors_n = self.model1_elements[n].uv_vectors_n
                else:
                    print "WARNING: the uv vectors CANNOT be morphed because have different dimensions: " + str(self.model1_elements[n].uv_vectors_n) + \
                    "(model 1), " + str(self.model2_elements[n].uv_vectors_n) + "(model 2)"
                    if self.model2choose_for_uneq_array == 1:
                        print "\t the uv vectors of the FIRST model will be used for \"morphed\" model" 
                        tmp_model_elements.uv_vectors = self.model1_elements[n].uv_vectors
                        tmp_model_elements.uv_vectors_n = self.model1_elements[n].uv_vectors_n
                    elif self.model2choose_for_uneq_array == 2:
                        print "\t the uv vectors of the SECOND model will be used for \"morphed\" model" 
                        tmp_model_elements.uv_vectors = self.model2_elements[n].uv_vectors
                        tmp_model_elements.uv_vectors_n = self.model2_elements[n].uv_vectors_n
                    
                # Do not morph the indices (simply keep those of the first or the second model)                
                if self.model2choose_for_uneq_array == 1:           
                    tmp_model_elements.face_indices = self.model1_elements[n].face_indices
                    tmp_model_elements.face_indices_n = self.model1_elements[n].face_indices_n
                    tmp_model_elements.uv_indices = self.model1_elements[n].uv_indices
                    tmp_model_elements.uv_indices_n = self.model1_elements[n].uv_indices_n     
                    tmp_model_elements.normal_indices = self.model1_elements[n].normal_indices
                    tmp_model_elements.normal_indices_n = self.model1_elements[n].normal_indices_n
                elif self.model2choose_for_uneq_array == 2:           
                    tmp_model_elements.face_indices = self.model2_elements[n].face_indices
                    tmp_model_elements.face_indices_n = self.model2_elements[n].face_indices_n
                    tmp_model_elements.uv_indices = self.model2_elements[n].uv_indices
                    tmp_model_elements.uv_indices_n = self.model2_elements[n].uv_indices_n     
                    tmp_model_elements.normal_indices = self.model2_elements[n].normal_indices
                    tmp_model_elements.normal_indices_n = self.model2_elements[n].normal_indices_n
                
                # Append to the list of the elements of the morphed model        
                self.morph_model_elements.append(tmp_model_elements)
            
            

    # ==================================== method: render_model ========================================
    def render_model( self, pov_file = "FACE_POV_scene.pov", out_name = None, out_folder = "output_morph/" ):
                                
        # command_string = "povray " + pov_file  + " +W791 +H652 +FN +AM1 +A -UA"
        
        # Render model
        command_string = "povray " + pov_file  + " +W" + str(self.mfact_def_frame*self.def_frame_width) + " +H" \
        + str(self.mfact_def_frame* self.def_frame_height) + " +FN +AM1 +A -UA"
        print "Command = " + command_string
        os.system(command_string)
        
        # Rename output file name
        if out_name:
            if not os.path.isdir( out_folder ):
                os.mkdir( out_folder )
            if out_folder[-1] != '/':
                out_folder += '/'        
            i_dot = findstr( pov_file, ".pov" )
            command_string = "cp " + pov_file[:i_dot[-1]] + ".png " + out_folder + out_name
            print command_string
            os.system(command_string)
        
        # pov_folder = "FACE/"
        # cd_string = "cd " + pov_folder 
        # command_string = "povray " + pov_file  + " +W791 +H652 +FN +AM1 +A -UA"     
        # print "cd string = " + cd_string
        # print "Command = " + command_string
        # os.system(cd_string)
        # os.system(command_string);
        # os.system(cd_string)
        
        
        
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  class Element3dModel  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@              
class Element3dModel:
            
    # ==================================== method: __init__ ========================================
    def __init__( self ):
        # Initialize file objects
        self.element_name = None
        # Data arrays
        self.vertex_vectors = None
        self.normal_vectors = None
        self.uv_vectors = None
        self.face_indices = None
        self.uv_indices = None
        self.normal_indices = None
        # Number of elements in each data array
        self.vertex_vectors_n = None
        self.normal_vectors_n = None
        self.uv_vectors_n = None
        self.face_indices_n = None
        self.uv_indices_n = None
        self.normal_indices_n = None


    # ==================================== method: check_consist_array_dim ========================================
    def check_consist_array_dim( self, array_name ):
        
        if array_name == "vertex_vectors":
            n_actual = self.vertex_vectors.shape[0]
            n_retrieved = self.vertex_vectors_n    
        elif array_name == "normal_vectors":
            n_actual = self.normal_vectors.shape[0]
            n_retrieved = self.normal_vectors_n
        elif array_name == "uv_vectors":
            n_actual = self.uv_vectors.shape[0]
            n_retrieved = self.uv_vectors_n
        elif array_name == "face_indices":
            n_actual = self.face_indices.shape[0]
            n_retrieved = self.face_indices_n            
        elif array_name == "uv_indices":
            n_actual = self.uv_indices.shape[0]
            n_retrieved = self.uv_indices_n            
        elif array_name == "normal_indices":
            n_actual = self.normal_indices.shape[0]
            n_retrieved = self.normal_indices_n            
                
        # Print result
        if n_actual == n_retrieved:    
            e_mess = "for the array: " + array_name + " the actual dimension (" + str(n_actual) + ") is consistent with the retrieved dimension (" + str(n_retrieved) + ")"
            print e_mess
        else:
            e_mess = "for the array: " + array_name + " the actual dimension (" + str(n_actual) + ") does not match the retrieved dimension (" + str(n_retrieved) + ")"
            raise Exception, e_mess


# ==================================== function: findstr ========================================
# Returns a list of indices where "substring" matches "string" (it is equivalent to Matlab findstr)
def findstr( string, substring ):

    if( isinstance( string, str ) and isinstance( substring, str ) ):
        i_out = []
        i = -1
        while 1:
            i = string.find( substring, i+1 )
            if i > -1:
                i_out.append(i)
            else:
                break
        return i_out
    else:
        raise Exception, "either argument of \"findstr()\" is NOT a string!"
