////////////////////////////////////////////////////////////////////////////////
//
//  ADOBE SYSTEMS INCORPORATED
//  Copyright 2008 Adobe Systems Incorporated
//  All Rights Reserved.
//
//  NOTICE: Adobe permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

package spark.components
{
	
import flash.events.Event;

import spark.components.supportClasses.TextBase;
import mx.core.mx_internal;
import mx.core.ScrollPolicy;
import mx.events.FlexEvent;
import spark.events.TextOperationEvent;

//--------------------------------------
//  Other metadata
//--------------------------------------

/**
 *  @copy spark.components.supportClasses.GroupBase#symbolColor
 *  
 *  @langversion 3.0
 *  @playerversion Flash 10
 *  @playerversion AIR 1.5
 *  @productversion Flex 4
 */ 
[Style(name="symbolColor", type="uint", format="Color", inherit="yes", theme="spark")]

[DefaultProperty("content")]

[IconFile("TextArea.png")]

/**
 *  Normal State
 *  
 *  @langversion 3.0
 *  @playerversion Flash 10
 *  @playerversion AIR 1.5
 *  @productversion Flex 4
 */
[SkinState("normal")]

/**
 *  Disabled State
 *  
 *  @langversion 3.0
 *  @playerversion Flash 10
 *  @playerversion AIR 1.5
 *  @productversion Flex 4
 */
[SkinState("disabled")]

/**
 *  Documentation is not currently available.
 *
 *  @includeExample examples/TextAreaExample.mxml
 *  
 *  @langversion 3.0
 *  @playerversion Flash 10
 *  @playerversion AIR 1.5
 *  @productversion Flex 4
 */
public class TextArea extends TextBase
{
    include "../core/Version.as";

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    /**
     *  Constructor. 
     *  
     *  @langversion 3.0
     *  @playerversion Flash 10
     *  @playerversion AIR 1.5
     *  @productversion Flex 4
     */    
	public function TextArea()
	{
		super();
	}

	//--------------------------------------------------------------------------
	//
	//  Variables
	//
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//
	//  Overridden properties
	//
	//--------------------------------------------------------------------------

	//----------------------------------
	//  text
	//----------------------------------

	[Bindable("change")]
	[Bindable("textChanged")]
    
    // Compiler will strip leading and trailing whitespace from text string.
    [CollapseWhiteSpace]
       
	/**
	 *  @private
	 */
    override public function set text(value:String):void
    {
        // Setting 'text' temporarily causes 'content' to become null.
        // Later, after the 'text' has been committed into the TextFlow,
        // getting 'content' will return the TextFlow.
        setContent(null);
        super.text = value;
        
        // Trigger bindings to textChanged.
        dispatchEvent(new Event("textChanged"));        
    }

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //----------------------------------
	//  content
    //----------------------------------

   /**
     *  @private
     *  Once the text or content is composed initially, the content getter
     *  will return the TextFlow, rather than the initial content.
     */
    private var useTextFlowForContent:Boolean = false;
    
	[Bindable("change")]
	[Bindable("contentChanged")]
	[Bindable("textChanged")]
	
	/**
	 *  Documentation is not currently available.
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 10
	 *  @playerversion AIR 1.5
	 *  @productversion Flex 4
	 */
	public function get content():Object
	{
	    return textView && useTextFlowForContent ? textView.textFlow : 
	                                               getContent();
	}

	/**
	 *  @private
	 */
	public function set content(value:Object):void
	{
		if (value == getContent())
			return;

        // Setting 'content' temporarily causes 'text' to become null.
        // Later, after the 'content' has been committed into the TextFlow,
        // getting 'text' will extract the text from the TextFlow.
        super.text = null;
        setContent(value);

        useTextFlowForContent = false;

        // Trigger bindings to contentChanged.
        dispatchEvent(new Event("contentChanged"));        
	}
    
	//----------------------------------
	//  heightInLines
    //----------------------------------

	/**
	 *  Documentation is not currently available.
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 10
	 *  @playerversion AIR 1.5
	 *  @productversion Flex 4
	 */
	public function get heightInLines():Number
	{
		return getHeightInLines();
	}

	/**
	 *  @private
	 */
	public function set heightInLines(value:Number):void
	{
        setHeightInLines(value);
	}
    
	//----------------------------------
	//  horizontalScrollPolicy
    //----------------------------------

	/**
	 *  @private
	 */
	private var _horizontalScrollPolicy:String = ScrollPolicy.AUTO;

    /**
     *  @private
     */
    private var horizontalScrollPolicyChanged:Boolean = false;
	
	/**
	 *  Documentation is not currently available.
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 10
	 *  @playerversion AIR 1.5
	 *  @productversion Flex 4
	 */
	public function get horizontalScrollPolicy():String
	{
		return _horizontalScrollPolicy;
	}

	/**
	 *  @private
	 */
	public function set horizontalScrollPolicy(value:String):void
	{
		if (value == _horizontalScrollPolicy)
			return;

		_horizontalScrollPolicy = value;
        horizontalScrollPolicyChanged = true;

		invalidateProperties();
	}
    
	//----------------------------------
	//  scroller
    //----------------------------------

    [SkinPart(required="false")]

    /**
     *  The optional Scroller used to scroll the RichEditableText.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 10
     *  @playerversion AIR 1.5
     *  @productversion Flex 4
     */
    public var scroller:Scroller;

	//----------------------------------
	//  verticalScrollPolicy
    //----------------------------------

	/**
	 *  @private
	 */
	private var _verticalScrollPolicy:String = ScrollPolicy.AUTO;

    /**
     *  @private
     */
    private var verticalScrollPolicyChanged:Boolean = false;
	
	/**
	 *  Documentation is not currently available.
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 10
	 *  @playerversion AIR 1.5
	 *  @productversion Flex 4
	 */
	public function get verticalScrollPolicy():String
	{
		return _verticalScrollPolicy;
	}

	/**
	 *  @private
	 */
	public function set verticalScrollPolicy(value:String):void
	{
		if (value == _verticalScrollPolicy)
			return;

		_verticalScrollPolicy = value;
        verticalScrollPolicyChanged = true;

		invalidateProperties();
	}
        
	//--------------------------------------------------------------------------
    //
    //  Overridden methods
    //
    //--------------------------------------------------------------------------
        
	/**
	 *  @private
	 *  Pushes various TextInput properties down into the RichEditableText. 
	 */
    override protected function commitProperties():void
	{
        super.commitProperties();
        
        if (horizontalScrollPolicyChanged)
        {
            if (scroller)
                scroller.horizontalScrollPolicy = _horizontalScrollPolicy;
            horizontalScrollPolicyChanged = false;
        }

        if (verticalScrollPolicyChanged)
        {
            if (scroller)
                scroller.verticalScrollPolicy = _verticalScrollPolicy;
            verticalScrollPolicyChanged = false;
        }
	}

	/**
	 *  @private
	 */
	override protected function partAdded(partName:String, instance:Object):void
	{
        super.partAdded(partName, instance);

		if (instance == textView)
		{
			// In default.css, the TextArea selector has a declaration
			// for lineBreak which sets it to "toFit".  It needs to be on
			// TextArea rather than RichEditableText so that if changed later it
			// will be inherited.

			textView.heightInLines = 10;
			textView.multiline = true;
            textView.autoSize = false;

            textView.addEventListener("textInvalid",
									  textView_textInvalidHandler);

            textView.addEventListener(FlexEvent.UPDATE_COMPLETE, 
                                      textView_updateCompleteHandler);
        }
        
        // The scroller, between textView and this in the chain, should not 
        // getFocus.
        if (instance == scroller)
            scroller.focusEnabled = false;
	}

    /**
     *  @private
     */
    override protected function partRemoved(partName:String, instance:Object):void
    {
        super.partRemoved(partName, instance);

        if (instance == textView)
        {
            textView.removeEventListener("textInvalid",
                                          textView_textInvalidHandler);

            textView.removeEventListener(FlexEvent.UPDATE_COMPLETE, 
                                         textView_updateCompleteHandler);
        }
    }
    
	//--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

	/**
	 *  Documentation is not currently available.
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 10
	 *  @playerversion AIR 1.5
	 *  @productversion Flex 4
	 */
    public function export():XML
    {
        if (!textView)
            return null;

        return textView.export();
    }

	/**
	 *  Documentation is not currently available.
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 10
	 *  @playerversion AIR 1.5
	 *  @productversion Flex 4
	 */
    public function getSelectionFormat(names:Array = null):Object
    {
        if (!textView)
            return null;

        return textView.getSelectionFormat(names);
    }

	/**
	 *  Documentation is not currently available.
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 10
	 *  @playerversion AIR 1.5
	 *  @productversion Flex 4
	 */
    public function setSelectionFormat(attributes:Object):void
    {
        if (!textView)
            return;

        textView.setSelectionFormat(attributes);
    }

	//--------------------------------------------------------------------------
    //
    //  Overridden event handlers: TextBase
    //
    //--------------------------------------------------------------------------

    /**
     *  @private
     *  Dispatched when there is an editing operation in RichEditableText.
     */
    override protected function textView_changeHandler(
                                        event:TextOperationEvent):void
	{
		// Note: We don't call the superhandler here
        // because it immediately fetches textView.text
        // to extract the text from the TextFlow.
        // That's too expensive for an TextArea,
        // which might have a lot of leaf nodes.
       
        useTextFlowForContent = true;
        		
		// Redispatch the event that came from the RichEditableText.
		dispatchEvent(event);
	}

	//--------------------------------------------------------------------------
    //
    //  Event handlers
    //
    //--------------------------------------------------------------------------

    /**
     *  @private
     *  Content changed or in process of being changed.
     */
    private function textView_textInvalidHandler(event:Event):void
    {
        mx_internal::textInvalid = true;
    }

    /**
     *  @private
     *  Called when the RichEditableText dispatches a 
     *  'FlexEvent.UPDATE_COMPLETE' event in response to validation being
     *  completed.  At this point, the textFlow is composed and the text
     *  can be extracted from the textFlow, if needed.
     */
    protected function textView_updateCompleteHandler(event:Event):void
    {
        // This handles the case where text or content is initially set and
        // no editing operations were done.  Since no editing operations
        // were done, a change event wasn't dispatched to trigger any bindings
        // on text or content.  The alternative is to let the RichEditableText
        // damageHandler dispatch for every updateDisplayList but that seems
        // much more expensive since the text may still be valid.
        if (!useTextFlowForContent)
        {
            useTextFlowForContent = true;
            dispatchEvent(new Event("change"));
       }
    }
}

}
